//
//  AvatarsModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 19/08/23.
//

import Foundation

struct AvatarsModel: Identifiable, Codable {
  let id: String
  let urlAvatar: String

  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case urlAvatar
  }
}
