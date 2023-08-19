//
//  OrderInternalModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import Foundation

struct OrdersModel: Identifiable {
  let id: String
  let urlPhoto: String
  let quantity: Int
  let price: String
  let name: String
}
