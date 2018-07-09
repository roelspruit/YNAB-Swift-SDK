//
//  YNABAPI+Categories.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol CategoriesRequesting {
    func getCategories(budgetId: String, completion: @escaping ([CategoryGroup]?) -> Void)
    func getCategory(budgetId: String, categoryId: String, completion: @escaping(Category?) -> Void)
}

extension CategoriesRequesting where Self: YNABAPI {
    
    public func getCategories(budgetId: String, completion: @escaping ([CategoryGroup]?) -> Void) {
        getData(type: DataResponse<CategoryGroupsWrapper>.self, relativeURL: "/budgets/\(budgetId)/categories") { (model) in
            completion(model?.data.category_groups)
        }
    }
    
    public func getCategory(budgetId: String, categoryId: String, completion: @escaping(Category?) -> Void) {
        getData(type: DataResponse<CategoryWrapper>.self, relativeURL: "/budgets/\(budgetId)/categories/\(categoryId)") { (model) in
            completion(model?.data.category)
        }
    }
}

struct CategoryGroupsWrapper: Decodable {
    var category_groups: [CategoryGroup]
}

struct CategoryWrapper: Decodable {
    var category: Category
}
