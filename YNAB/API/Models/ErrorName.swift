//
//  ErrorName.swift
//  YNAB
//
//  Created by Roel Spruit on 09/07/2018.
//  Copyright © 2018 dinkywonder. All rights reserved.
//

import Foundation

public enum ErrorName: String, Decodable {
    case bad_request
    case not_authorized
    case subscription_lapsed
    case trial_expired
    case not_found
    case resource_not_found
    case too_many_requests
    case internal_server_error
}
