//
//  YNABAPIError.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct ErrorDetail: Decodable {
    public var id: String
    public var name: ErrorName
    public var detail: String
}

public struct ErrorResponse: Decodable {
    public var error: ErrorDetail
}
