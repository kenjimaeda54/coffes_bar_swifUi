//
//  OrdersByUserModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import Foundation

struct OrdersByUserModel: Codable, Identifiable {
  let id: String
  let orders: [Orders]
  let priceCartTotal: String
  let tax: String
  let userId: String

  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case orders
    case priceCartTotal
    case tax
    case userId
  }
}

struct Orders: Codable, Identifiable {
  let id: String
  let title: String
  let price: String
  let quantity: Int
  let urlImage: String
  let coffeeId: String

  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case price
    case quantity
    case urlImage
    case coffeeId
  }
}
