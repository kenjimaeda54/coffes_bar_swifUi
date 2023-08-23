//
//  UsersModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

struct UsersModel: Codable {
  let id: String
  let name: String
  let email: String
  let avatarId: String
  let password: String

  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name
    case email
    case avatarId
    case password
  }
}
