//
//  Budget.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct Budget: Decodable {
    public var id: String
    public var name: String
    public var accounts: [Account]
    public var payees: [Payee]
    public var payee_locations: [PayeeLocation]
    public var categories: [Category]
    public var transactions: [Transaction]
    //public var subtransactions: [Transaction]
    public var scheduled_transactions: [Transaction]
    public var scheduled_subtransactions: [Transaction]
    public var months: [Month]
}

public struct BudgetSummary: Decodable {
    public var id: String
    public var name: String
}
