//
//  WebService.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/23.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequest(url: URL?, method: String?)
    case decodingError(data: Data?)
}
