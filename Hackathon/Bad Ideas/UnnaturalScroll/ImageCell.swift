//
//  ImageCell.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import UIKit

final class ImageCell: UITableViewCell {

    private let heroImageView = UIImageView()
    private let label = with(UILabel()) {
        $0.numberOfLines = 0
    }
    private var aspectConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // View Hierarchy
        let labelStackView = UIStackView(arrangedSubviews: [label])
        let cellStackView = UIStackView(arrangedSubviews: [heroImageView, labelStackView])
        contentView.addSubview(cellStackView)

        // Layout
        labelStackView.isLayoutMarginsRelativeArrangement = true
        labelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        cellStackView.edgeAnchors == contentView.edgeAnchors
        cellStackView.axis = .vertical
        cellStackView.spacing = 4
        cellStackView.isLayoutMarginsRelativeArrangement = true
        cellStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        // Configuration
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(withImage image: UIImage, title: String) {
        heroImageView.image = image
        label.text = title
        let aspect = image.size.width / image.size.height
        aspectConstraint?.isActive = false
        aspectConstraint = heroImageView.widthAnchor == heroImageView.heightAnchor * aspect
    }

}
