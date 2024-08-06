//
//  Error.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
