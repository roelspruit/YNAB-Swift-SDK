//
//  YNABAPI+Accounts.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol AccountsRequesting {
    func getAccounts(budgetId: String, completion: @escaping ([Account]?) -> Void)
    func getAccount(budgetId: String, accountId: String, completion: @escaping (Account?) -> Void)
}

extension AccountsRequesting where Self: YNABAPI {
    
    public func getAccounts(budgetId: String, completion: @escaping ([Account]?) -> Void) {
        getData(type: DataResponse<AccountsWrapper>.self, relativeURL: "/budgets/\(budgetId)/accounts") { (model) in
            completion(model?.data.accounts)
        }
    }
    
    public func getAccount(budgetId: String, accountId: String, completion: @escaping (Account?) -> Void) {
        getData(type: DataResponse<AccountWrapper>.self, relativeURL: "/budgets/\(budgetId)/accounts/\(accountId)") { (model) in
            completion(model?.data.account)
        }
    }
}

struct AccountsWrapper: Decodable {
    var accounts: [Account]
}

struct AccountWrapper: Decodable {
    var account: Account
}
