//
//  YNABAPI+Transactions.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    func getTransactions(budgetId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: TransactionsResponse.self, relativeURL: "/budgets/\(budgetId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    func getTransactions(budgetId: String, accountId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: TransactionsResponse.self, relativeURL: "/budgets/\(budgetId)/accounts/\(accountId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    func getTransactions(budgetId: String, categoryId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: TransactionsResponse.self, relativeURL: "/budgets/\(budgetId)/categories/\(categoryId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    func getTransactions(budgetId: String, payeeId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: TransactionsResponse.self, relativeURL: "/budgets/\(budgetId)/payees/\(payeeId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    func getTransaction(budgetId: String, transactionId: String, completion: @escaping (Transaction?) -> Void) {
        getData(type: TransactionResponse.self, relativeURL: "/budgets/\(budgetId)/transactions/\(transactionId)") { (model) in
            completion(model?.data.transaction)
        }
    }
    
}

struct TransactionsResponse: Decodable {
    var data: TransactionsWrapper
}

struct TransactionsWrapper: Decodable {
    var transactions: [Transaction]
}

struct TransactionResponse: Decodable {
    var data: TransactionWrapper
}

struct TransactionWrapper: Decodable {
    var transaction: Transaction
}


