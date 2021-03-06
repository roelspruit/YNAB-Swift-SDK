//
//  SaveTransaction.swift
//  YNAB
//
//  Created by Roel Spruit on 09/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct SaveTransaction: Codable {
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
    
    public init(date: String,
                amount: Double,
                account_id: String,
                category_id: String?,
                approved: Bool,
                cleared: TransactionClearedState,
                flag_color: TransactionFlagColor? = nil,
                payee_id: String? = nil,
                payee_name: String? = nil,
                memo: String? = nil,
                import_id: String? = nil) {
        
        self.date = date
        self.amount = amount
        self.account_id = account_id
        self.category_id = category_id
        self.payee_id = payee_id
        self.payee_name = payee_name
        self.memo = memo
        self.import_id = import_id
        self.approved = approved
        self.cleared = cleared
        self.flag_color = flag_color
    }
}

public struct SaveTransactionWrapper: Codable {
    public var transaction: SaveTransaction
}
