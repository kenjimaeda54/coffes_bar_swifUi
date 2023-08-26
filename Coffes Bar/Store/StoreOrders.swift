//
//  StoreOrders.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 24/08/23.
//

import Foundation

class StoreOrders: ObservableObject {
  @Published var loading = LoadingState.loading
  var orderByUser: [OrdersByUserModel] = []

  func fetchAnOrderByUser(_ id: String) {
    OrderService().fetchAnOrder(withIdUser: id) { result in

      switch result {
      case let .success(order):

        DispatchQueue.main.async {
          self.orderByUser = order
          self.loading = LoadingState.sucess
        }

      case let .failure(error):
        print(error)

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }

  func createOrdersCart(_ params: CartByUserModel) {
    OrderService().createOrderByCart(params: params) { result in

      switch result {
      case var .success(stats):

        DispatchQueue.main.async {
          self.loading = LoadingState.sucess
        }

      case var .failure(error):

        print(error)

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
        }
      }
    }
  }
}
