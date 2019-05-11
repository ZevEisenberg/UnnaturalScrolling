//
//  ViewController.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import UIKit

class RootViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let dataSource = ListDataSource(sections: [
        Section(items: [
            Item(title: "Scrolling", vcClass: UnnaturalScrollViewController.self),
            ]),
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // View Hierarchy
        view.addSubview(tableView)

        // Layout
        tableView.edgeAnchors == view.edgeAnchors

        // Setup
        title = "This was a mistake"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}

extension RootViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath]
        let instance = item.vcClass.init()
        instance.title = item.title
        navigationController?.pushViewController(instance, animated: true)
    }

}

private extension RootViewController {

    struct Item {
        let title: String
        let vcClass: UIViewController.Type
    }

    struct Section: ListSection {
        var items: [Item]
    }

}
