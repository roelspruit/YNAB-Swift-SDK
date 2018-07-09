//
//  YNABAPI+User.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public extension YNABAPI {
    
    func getUser(completion: @escaping (User?) -> Void) {
        getData(type: DataResponse<UserWrapper>.self, relativeURL: "/user") { (model) in
            completion(model?.data.user)
        }
    }
}

struct UserWrapper: Decodable {
    var user: User
}
