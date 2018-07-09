//
//  YNABAPIError.swift
//  YNAB
//
//  Created by Roel Spruit on 08/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public struct YNABError: Decodable {
    public var id: String
    public var name: String
    public var detail: String
}

public struct YNABErrorWrapper: Decodable {
    public var error: YNABError
}
