//
//  NetWorkError.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 22/08/23.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case invalidRequest
  case noData
  case badDecoding
}
