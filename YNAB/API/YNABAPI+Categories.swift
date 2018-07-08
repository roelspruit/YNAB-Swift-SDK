//
//  YNABAPI+Categories.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    func getCategories(budgetId: String, completion: @escaping ([CategoryGroup]?) -> Void) {
        getData(type: CategoriesResponse.self, relativeURL: "/budgets/\(budgetId)/categories") { (model) in
            completion(model?.data.category_groups)
        }
    }
    
    func getCategory(budgetId: String, categoryId: String, completion: @escaping(Category?) -> Void) {
        getData(type: CategoryResponse.self, relativeURL: "/budgets/\(budgetId)/categories/\(categoryId)") { (model) in
            completion(model?.data.category)
        }
    }
}

struct CategoriesResponse: Decodable {
    var data: CategoryGroupsWrapper
}

struct CategoryGroupsWrapper: Decodable {
    var category_groups: [CategoryGroup]
}

struct CategoryResponse: Decodable {
    var data: CategoryWrapper
}

struct CategoryWrapper: Decodable {
    var category: Category
}
