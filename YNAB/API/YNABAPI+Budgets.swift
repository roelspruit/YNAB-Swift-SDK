//
//  YNABAPI+Budgets.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    public func getBudgets(completion: @escaping ([BudgetSummary]?) -> Void) {
        getData(type: DataResponse<BudgetSummaryWrapper>.self, relativeURL: "/budgets") { (model) in
            completion(model?.data.budgets)
        }
    }
    
    func getBudget(budgetId: String, completion: @escaping (Budget?) -> Void) {
        getData(type: DataResponse<BudgetDetailWrapper>.self, relativeURL: "/budgets/\(budgetId)") { (model) in
            completion(model?.data.budget)
        }
    }
    
    func getBudgetSettings(budgetId: String, completion: @escaping (BudgetSettings?) -> Void) {
        getData(type: DataResponse<BudgetSettingsWrapper>.self, relativeURL: "/budgets/\(budgetId)/settings") { (model) in
            completion(model?.data.settings)
        }
    }    
}

struct BudgetSummaryWrapper: Decodable {
    var budgets: [BudgetSummary]
}

struct BudgetDetailWrapper: Decodable {
    var budget: Budget?
}

struct BudgetSettingsWrapper: Decodable {
    var settings: BudgetSettings?
}

