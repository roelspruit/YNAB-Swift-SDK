//
//  Transaction.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct Transaction: Codable {
    public var id: String?
    public var date: String
    public var amount: Double
    public var account_id: String
    public var category_id: String?
    public var payee_id: String?
    public var payee_name: String?
    public var memo: String?
    public var import_id: String?
    public var approved: Bool
    public var cleared: TransactionClearedState
    public var flag_color: TransactionFlagColor?
}
