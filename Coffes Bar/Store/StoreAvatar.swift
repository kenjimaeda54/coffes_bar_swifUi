//
//  StoreAvatar.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

class StoreAvatar: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var avatar: [AvatarsModel] = []
  @Published var avatarByUser = AvatarsModel(id: "", urlAvatar: "")

  func fetchAllAvatar() {
    AvatarWebService().fetchAllAvatar { result in

      switch result {
      case let .success(avatar):

        DispatchQueue.main.async {
          self.loading = LoadingState.sucess
          self.avatar = avatar
        }

      case let .failure(error):

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func fetchAnAvatar(_ id: String) {
    AvatarWebService().fetchAnAvatar(withId: id) { result in

      switch result {
      case let .success(data):

        DispatchQueue.main.async {
          self.avatarByUser = data
          self.loading = LoadingState.sucess
        }

      case let .failure(error):

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }
}
