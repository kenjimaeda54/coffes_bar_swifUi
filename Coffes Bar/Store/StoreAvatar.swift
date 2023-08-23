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

  func fetchAvatar() {
    AvatarWebService().fetchAvatar { result in

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
}
