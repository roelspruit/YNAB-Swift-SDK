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
        getData(type: BudgetSummaryResponse.self, relativeURL: "/budgets") { (model) in
            completion(model?.data.budgets)
        }
    }
    
    func getBudget(budgetId: String, completion: @escaping (Budget?) -> Void) {
        getData(type: BudgetDetailResponse.self, relativeURL: "/budgets/\(budgetId)") { (model) in
            completion(model?.data.budget)
        }
    }
    func getBudgetSettings(budgetId: String, completion: @escaping (BudgetSettings?) -> Void) {
        getData(type: BudgetSettingsResponse.self, relativeURL: "/budgets/\(budgetId)/settings") { (model) in
            completion(model?.data.settings)
        }
    }
}

struct BudgetSummaryResponse: Decodable {
    var data: BudgetSummaryWrapper
}

struct BudgetSummaryWrapper: Decodable {
    var budgets: [BudgetSummary]
}

struct BudgetDetailResponse: Decodable {
    var data: BudgetDetailWrapper
}

struct BudgetDetailWrapper: Decodable {
    var budget: Budget?
}

struct BudgetSettingsResponse: Decodable {
    var data: BudgetSettingsWrapper
}

struct BudgetSettingsWrapper: Decodable {
    var settings: BudgetSettings?
}
