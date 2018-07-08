//
//  Transaction.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct Transaction: Decodable {
    public var id: String
    public var date: String
    public var payee_name: String?
}
