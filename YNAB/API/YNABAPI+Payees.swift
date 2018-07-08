//
//  YNABAPI+Payees.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    func getPayees(budgetId: String, completion: @escaping([Payee]?) -> Void) {
        getData(type: PayeesResponse.self, relativeURL: "/budgets/\(budgetId)/payees") { (model) in
            completion(model?.data.payees)
        }
    }
    
    func getPayee(budgetId: String, payeeId: String, completion: @escaping(Payee?) -> Void) {
        getData(type: PayeeResponse.self, relativeURL: "/budgets/\(budgetId)/payees/\(payeeId)") { (model) in
            completion(model?.data.payee)
        }
    }
}

struct PayeesResponse: Decodable {
    var data: PayeesWrapper
}

struct PayeesWrapper: Decodable {
    var payees: [Payee]
}

struct PayeeResponse: Decodable {
    var data: PayeeWrapper
}

struct PayeeWrapper: Decodable {
    var payee: Payee
}


