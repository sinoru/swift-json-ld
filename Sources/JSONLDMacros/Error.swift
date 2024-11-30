//
//  Error.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

enum Error: Swift.Error, CustomStringConvertible {
  case message(String)

  var description: String {
    switch self {
    case .message(let text):
      return text
    }
  }
}
