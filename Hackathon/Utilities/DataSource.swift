//
//  DataSource.swift
//  Hackathon
//
//  Created by Zev Eisenberg on 5/11/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Foundation.NSIndexPath

protocol ListSection {
    associatedtype ItemType
    var items: [ItemType] { get }
}

extension ListSection {
    var count: Int {
        return items.count
    }

    subscript(index: Int) -> ItemType {
        return items[index]
    }
}

struct ListDataSource<SectionType: ListSection> {
    let sections: [SectionType]

    subscript(section: Int) -> SectionType {
        return sections[section]
    }

    subscript(indexPath: IndexPath) -> SectionType.ItemType {
        return sections[indexPath.section][indexPath.row]
    }
}
