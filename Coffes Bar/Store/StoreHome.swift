//
//  HomeViewModel.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import Foundation

class StoreHome: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var coffees: [CoffeesModel] = []

  func fetchAllCoffes() {
    CoffeeWebService().fetchAllCoffes(completion: { result in

      switch result {
      case let .success(data):

        DispatchQueue.main.async {
          self.coffees = data
          self.loading = LoadingState.sucess
        }

      case let .failure(error):
        print(error)

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }

    })
  }
}
