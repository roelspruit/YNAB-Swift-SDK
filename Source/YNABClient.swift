//
//  YNABClient.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public class YNABClient: YNABAPI, BudgetRequesting, AccountsRequesting, CategoriesRequesting, PayeesRequesting, TransactionsRequesting, UserRequesting {
    
    public var accessToken: AccessToken
    
    public init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
}
