//
//  PayeeLocation.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct PayeeLocation: Decodable {
    public var id: String
    public var payee_id: String
    public var latitude: String
    public var longitude: String
    public var deleted: Bool
}
