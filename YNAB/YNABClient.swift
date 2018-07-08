//
//  YNABClient.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public class YNABClient: YNABAPI {
    
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
