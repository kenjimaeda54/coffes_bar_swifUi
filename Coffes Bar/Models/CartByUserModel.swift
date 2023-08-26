//
//  CartUserModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 25/08/23.
//

import Foundation

struct CartByUserModel: Codable {
  let cart: DemandByUserModel
}

struct DemandByUserModel: Codable {
  let orders: [OrdersByUser]
  let priceCartTotal: String
  let userId: String
  let tax: String
}

struct OrdersByUser: Codable {
  let title: String
  let urlImage: String
  let price: String
  let quantity: Int
}
