//
//  Error.swift
//  Word
//
//  Created by Matteo on 11/11/2021.
//

import Foundation

enum WordError: String, Error {
    case unknown = "Something went wrong"
    case wordNotFound = "Word not found."
}
