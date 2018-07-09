//
//  YNABAPI+Transactions.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol TransactionsRequesting {
    func getTransactions(budgetId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, accountId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, categoryId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, payeeId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransaction(budgetId: String, transactionId: String, completion: @escaping (Transaction?) -> Void)
}

extension TransactionsRequesting where Self: YNABAPI {
    
    public func getTransactions(budgetId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: DataResponse<TransactionsWrapper>.self, relativeURL: "/budgets/\(budgetId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    public func getTransactions(budgetId: String, accountId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: DataResponse<TransactionsWrapper>.self, relativeURL: "/budgets/\(budgetId)/accounts/\(accountId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    public func getTransactions(budgetId: String, categoryId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: DataResponse<TransactionsWrapper>.self, relativeURL: "/budgets/\(budgetId)/categories/\(categoryId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    public func getTransactions(budgetId: String, payeeId: String, completion: @escaping ([Transaction]?) -> Void) {
        getData(type: DataResponse<TransactionsWrapper>.self, relativeURL: "/budgets/\(budgetId)/payees/\(payeeId)/transactions") { (model) in
            completion(model?.data.transactions)
        }
    }
    
    public func getTransaction(budgetId: String, transactionId: String, completion: @escaping (Transaction?) -> Void) {
        getData(type: DataResponse<TransactionWrapper>.self, relativeURL: "/budgets/\(budgetId)/transactions/\(transactionId)") { (model) in
            completion(model?.data.transaction)
        }
    }
    
    public func createTransaction(transaction: SaveTransaction, budgetId: String, completion: @escaping (Transaction?) -> Void) {
        let creationRequest = SaveTransactionWrapper(transaction: transaction)
        postData(type: TransactionWrapper.self, body: creationRequest, relativeURL: "/budgets/\(budgetId)/transactions") { (model) in
            completion(model?.transaction)
        }
    }    
}

struct TransactionsWrapper: Decodable {
    var transactions: [Transaction]
}

struct TransactionWrapper: Decodable {
    var transaction: Transaction
}


