//
//  CoffesModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import Foundation

struct CoffeesModel: Identifiable, Codable {
  let id: String
  let urlPhoto: String
  let name: String
  let description: String
  let quantityMl: [String]
  let price: String

  // quando estiver usando CodingKeys se der erro protoloco não e Codable ou Decoble
  // porque precisa todos os valores no CodingKeys
  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case urlPhoto
    case name
    case description
    case quantityMl
    case price
  }
}
