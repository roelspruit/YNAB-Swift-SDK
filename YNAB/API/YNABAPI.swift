//
//  YNABAPI.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public protocol YNABAPI {
    var ynabBaseUrl: String { get }
    var accessToken: AccessToken { get }
}

extension YNABAPI {
    
    public var ynabBaseUrl: String {
        return "https://api.youneedabudget.com/v1"
    }
    
    func getData<T: Decodable>(type: T.Type, relativeURL: String, completion: @escaping (_ model: T?) -> Void) {
        
        var request = URLRequest(url: fullUrl(relativeURL))
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.handleResponse(type: type, data: data, completion: completion)
        }.resume()
    }
    
    func postData<T: Decodable, U: Encodable>(type: T.Type, body: U, relativeURL: String, completion: @escaping (_ model: T?) -> Void) {
        
        var request = URLRequest(url: fullUrl(relativeURL))
        request.setValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
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
            self.handleResponse(type: type, data: data, completion: completion)
        }.resume()
    }
    
    private func fullUrl(_ relativeURL: String) -> URL {
        return URL(string: ynabBaseUrl + relativeURL)!
    }
    
    private func handleResponse<T: Decodable>(type: T.Type, data: Data?, completion: @escaping (_ model: T?) -> Void) {
        
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
//        if let string = String(data: data, encoding: String.Encoding.utf8) {
//            print(string)
//        }
        
        let decoder = JSONDecoder()
        
        if let model = try? decoder.decode(ErrorResponse.self, from: data) {
            print("Error in response: \(model)")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        if let model = try? decoder.decode(T.self, from: data) {
            DispatchQueue.main.async {
                completion(model)
            }
            return
        }
        
        DispatchQueue.main.async {
            completion(nil)
        }
    }
}
