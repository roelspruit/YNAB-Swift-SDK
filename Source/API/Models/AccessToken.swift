//
//  AccessToken.swift
//  YNAB
//
//  Created by Roel Spruit on 09/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct AccessToken: Codable {
    var token: String
    var expirationDate: Date
    
    public var expired: Bool {
        return !(Date().compare(expirationDate) == ComparisonResult.orderedAscending)
    }
}
