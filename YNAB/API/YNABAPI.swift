//
//  YNABAPI.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol YNABAPI {
    
    var ynabBaseUrl: String {get}
    var accessToken: String { get }
    
    // User
    func getUser(completion: @escaping (User?) -> Void)
    
    // Budgets
    func getBudgets(completion: @escaping ([BudgetSummary]?) -> Void)
    func getBudget(budgetId: String, completion: @escaping (Budget?) -> Void)
    func getBudgetSettings(budgetId: String, completion: @escaping (BudgetSettings?) -> Void)
    
    // Accounts
    func getAccounts(budgetId: String, completion: @escaping ([Account]?) -> Void)
    func getAccount(budgetId: String, accountId: String, completion: @escaping (Account?) -> Void)

    // Categories
    func getCategories(budgetId: String, completion: @escaping ([CategoryGroup]?) -> Void)
    func getCategory(budgetId: String, categoryId: String, completion: @escaping(Category?) -> Void)

    // Payees
    func getPayees(budgetId: String, completion: @escaping ([Payee]?) -> Void)
    func getPayee(budgetId: String, payeeId: String, completion: @escaping(Payee?) -> Void)
    
    // Transactions
    func getTransactions(budgetId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, accountId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, categoryId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransactions(budgetId: String, payeeId: String, completion: @escaping ([Transaction]?) -> Void)
    func getTransaction(budgetId: String, transactionId: String, completion: @escaping (Transaction?) -> Void)
}

extension YNABAPI {
    
    public var ynabBaseUrl: String {
        return "https://api.youneedabudget.com/v1"
    }
    
    func getData<T: Decodable>(type: T.Type, relativeURL: String, completion: @escaping (_ model: T?) -> Void) {
        
        let fullUrl = ynabBaseUrl + relativeURL
        guard let url = URL(string: fullUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                completion(model)
                
            } catch let error {
                print(error)
                completion(nil)
            }
            
        }.resume()
    }
    
    func postData<T: Decodable, U: Encodable>(type: T.Type, body: U, relativeURL: String, completion: @escaping (_ model: T?) -> Void) {
        
        let fullUrl = ynabBaseUrl + relativeURL
        guard let url = URL(string: fullUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode(YNABAPIError.self, from: data)
                print("Error in response: \(model)")
                completion(nil)
            } catch  {
                // do nothing
            }
            
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                print(string)
            }
            
            do {
                let model = try decoder.decode(T.self, from: data)
                completion(model)
            } catch let error {
                print(error)
                completion(nil)
            }
            
            }.resume()
    }
}
