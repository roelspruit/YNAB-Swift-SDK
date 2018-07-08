//
//  YNABAPI+Accounts.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    func getAccounts(budgetId: String, completion: @escaping ([Account]?) -> Void) {
        getData(type: AccountsResponse.self, relativeURL: "/budgets/\(budgetId)/accounts") { (model) in
            completion(model?.data.accounts)
        }
    }
    
    func getAccount(budgetId: String, accountId: String, completion: @escaping (Account?) -> Void) {
        getData(type: AccountResponse.self, relativeURL: "/budgets/\(budgetId)/accounts/\(accountId)") { (model) in
            completion(model?.data.account)
        }
    }
}

struct AccountsResponse: Decodable {
    var data: AccountsWrapper
}

struct AccountsWrapper: Decodable {
    var accounts: [Account]
}

struct AccountResponse: Decodable {
    var data: AccountWrapper
}

struct AccountWrapper: Decodable {
    var account: Account
}
