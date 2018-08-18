//
//  Category.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct Category: Codable {
    public var id: String
    public var name: String
    public var category_group_id: String
    public var hidden: Bool
}
