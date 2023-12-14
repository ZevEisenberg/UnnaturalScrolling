import Anchorage
import Swiftilities
import UIKit

final class UnnaturalScrollViewController: UIViewController {

    private let tableView = UITableView()
    private let scrollView = UIScrollView()

    private let dataSource = ListDataSource(sections: [
        Section(items: Constants.titles
            .enumerated()
            .map { offset, title in Item(title: title, assetName: "PastHacks/\(offset)") }
        ),
        ]
    )

    private var observation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        title = "2018 Stupid Hacks"

        // View Hierarchy
        view.addSubview(tableView)
        view.addSubview(scrollView)

        // Layout
        tableView.edgeAnchors == view.edgeAnchors
        scrollView.edgeAnchors == view.edgeAnchors

        // Setup
        scrollView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(ImageCell.self, forCellReuseIdentifier: "cell")

        tableView.showsVerticalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        tableView.contentInsetAdjustmentBehavior = .automatic
        scrollView.contentInsetAdjustmentBehavior = .never

        observation = tableView.observe(\.contentSize, options: [.new, .initial]) { [weak self] _, change in
            guard let self = self else { return }
            guard
                let newValue = change.newValue,
                newValue != self.scrollView.contentSize
                else { return }
            self.updateScrollViewToMatchTableView()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newInsets = UIEdgeInsets(
            top: tableView.safeAreaInsets.bottom,
            left: tableView.safeAreaInsets.right,
            bottom: tableView.safeAreaInsets.top,
            right: tableView.safeAreaInsets.left
        )
        scrollView.contentInset = newInsets
    }

}

extension UnnaturalScrollViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath]
        let image = UIImage(named: item.assetName)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageCell
        cell.update(withImage: image, title: item.title)
        return cell
    }

}

extension UnnaturalScrollViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxScrollValue = tableView.contentSize.height - tableView.frame.height
        guard maxScrollValue > 0 else { return }
        let distanceToScroll = 0...(maxScrollValue)
        let newOffset = scrollView.contentOffset.y.scaled(
            from: distanceToScroll,
            to: distanceToScroll,
            reversed: true
        )
        tableView.contentOffset.y = newOffset
    }

}

private extension UnnaturalScrollViewController {

    enum Constants {
        static let titles = [
            "Swarm of Babies",
            "BEEPASS",
            "Infinite Cha-cha slide / WebMG",
            "Ad Plus",
            "2D Anime Dating",
            "Fart Detector",
            "Life Aware",
            "Useless Button",
            "Twitter Firehose",
            "Civilized Hamster dining set",
            "Death Counter",
            "Tuned a fish",
        ]
    }

    struct Item {
        let title: String
        let assetName: String
    }

    struct Section: ListSection {
        var items: [Item]
    }

    func updateScrollViewToMatchTableView() {
        scrollView.contentSize = tableView.contentSize
        let newOffset = tableView.contentSize.height
            - scrollView.bounds.height
            - tableView.contentOffset.y
        scrollView.contentOffset.y = newOffset
    }

}
