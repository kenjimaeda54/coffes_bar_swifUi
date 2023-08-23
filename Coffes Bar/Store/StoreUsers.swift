//
//  StoreUsers.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

class StoreUsers: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var user = UsersModel(id: "", name: "", email: "", avatarId: "", password: "")

  func creatUsers(params: [String: String]) {
    UserWebService().createUser(params: params) { result in

      switch result {
      case let .success(user):

        DispatchQueue.main.async {
          print(user.email)
          self.user = user
          self.loading = .sucess
        }

      case let .failure(error):
        print(error)
        DispatchQueue.main.async {
          self.loading = .failure
        }
      }
    }
  }
}
