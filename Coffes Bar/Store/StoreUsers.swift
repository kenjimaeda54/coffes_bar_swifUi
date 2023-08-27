//
//  StoreUsers.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

// desing patern MV https://github.com/azamsharp/MoviesAppMVPattern/tree/master

class StoreUsers: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var user = UsersModel(id: "", name: "", email: "", avatarId: "", password: "")

  func creatUsers(params: [String: String], completion: @escaping () -> Void) {
    UserWebService().createUser(params: params) { result in

      switch result {
      case let .success(user):

        DispatchQueue.main.async {
          self.user = user
          self.loading = .sucess
          completion()
        }

      case let .failure(error):
        print(error)
        DispatchQueue.main.async {
          self.loading = .failure
          completion()
        }
      }
    }
  }

  func loginUser(params: [String: String], completion: @escaping () -> Void) {
    UserWebService().loginUser(params: params) { result in

      switch result {
      case let .success(data):

        DispatchQueue.main.async {
          self.user = data
          self.loading = LoadingState.sucess
          completion()
        }

      case let .failure(error):

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
          completion()
        }
      }
    }
  }

  func updateUserAvatar(
    withUpdateAvatar: UpdateAvatarModel,
    andUserId userId: String,
    completion: @escaping (Bool) -> Void
  ) {
    UserWebService().updateAvatar(withUpateAvatar: withUpdateAvatar, andUserId: userId) { result in

      switch result {
      case let .success(stats):

        DispatchQueue.main.async {
          completion(stats)
        }

      case let .failure(error):

        DispatchQueue.main.async {
          print(error)
          completion(false)
        }
      }
    }
  }
}
