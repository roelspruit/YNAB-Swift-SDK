//
//  YNABAPI+Budgets.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol BudgetRequesting {
    func getBudgets(completion: @escaping ([BudgetSummary]?) -> Void)
}

extension BudgetRequesting where Self: YNABAPI {
    
    public func getBudgets(completion: @escaping ([BudgetSummary]?) -> Void) {
        getData(type: DataResponse<BudgetSummaryWrapper>.self, relativeURL: "/budgets") { (model) in
            completion(model?.data.budgets)
        }
    }
    
    public func getBudget(budgetId: String, completion: @escaping (Budget?) -> Void) {
        getData(type: DataResponse<BudgetDetailWrapper>.self, relativeURL: "/budgets/\(budgetId)") { (model) in
            completion(model?.data.budget)
        }
    }
    
    public func getBudgetSettings(budgetId: String, completion: @escaping (BudgetSettings?) -> Void) {
        getData(type: DataResponse<BudgetSettingsWrapper>.self, relativeURL: "/budgets/\(budgetId)/settings") { (model) in
            completion(model?.data.settings)
        }
    }
}

fileprivate struct BudgetSummaryWrapper: Decodable {
    var budgets: [BudgetSummary]    
}

fileprivate struct BudgetDetailWrapper: Decodable {
    var budget: Budget?
}

fileprivate struct BudgetSettingsWrapper: Decodable {
    var settings: BudgetSettings?
}

