//
//  TransactionClearedState.swift
//  YNAB
//
//  Created by Roel Spruit on 09/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public enum TransactionClearedState: String, Codable {
    case uncleared
    case reconciled
    case cleared
}
