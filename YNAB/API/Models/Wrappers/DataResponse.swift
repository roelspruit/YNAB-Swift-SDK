//
//  DataResponse.swift
//  YNAB
//
//  Created by Roel Spruit on 09/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

struct DataResponse<T: Decodable>: Decodable {
    var data: T
}
