//
//  OldOrders.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

// tudo sobre list
// https://www.codecademy.com/article/building-lists-in-swiftui
struct FavoriteOrders: View {
  @EnvironmentObject private var stateTabView: StateNavigationTabView
  @ObservedObject var order: CartObservable

  // depois clonar os dois
  // https://www.hackingwithswift.com/example-code/language/how-to-append-one-array-to-another-array
  @State private var auxiliaryUpdateOrder: [OrdersModel] = []
  @State private var auxiliaryOrder: [OrdersModel] = []

  func selectedOrder(_ orders: [Orders]) {
    orders.forEach { orders in
      if let index = order.cartOrder.firstIndex(where: { $0.id == orders.id }) {
        let orderRemoved = order.cartOrder.remove(at: index)
        let order = OrdersModel(
          id: orders.id,
          urlPhoto: orders.urlImage,
          quantity: orders.quantity + orderRemoved.quantity,
          price: orders.price,
          name: orders.title
        )
        auxiliaryUpdateOrder.append(order)

      } else {
        let order = OrdersModel(
          id: orders.id,
          urlPhoto: orders.urlImage,
          quantity: orders.quantity,
          price: orders.price,
          name: orders.title
        )
        auxiliaryOrder.append(order)
      }
    }

    // criei uma extensão pro spreed operator
    let concat = auxiliaryOrder...auxiliaryUpdateOrder
    order.cartOrder.append(contentsOf: concat)
    auxiliaryOrder = []
    auxiliaryUpdateOrder = []
    stateTabView.tagSelected = 1
  }

  var body: some View {
    List {
      ForEach(ordersByUserMock) { ordersGroup in
        Section {
          ForEach(ordersGroup.orders) { order in
            Button {
              selectedOrder(ordersGroup.orders)
            } label: {
              Order(
                order: OrdersModel(
                  id: order.id,
                  urlPhoto: order.urlImage,
                  quantity: order.quantity,
                  price: order.price,
                  name: order.title
                ),
                handlePlusQuantity: {},
                handleMinusQuantity: {}
              ) {}

                  .disabled(true)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            .listRowBackground(ColorsApp.black)
          }

        } header: {
          HeaderSectionFavoriteOrders()
        }
        .headerProminence(.increased)
      }
    }

    .listStyle(.grouped)
    .navigationBarTitleDisplayMode(.inline)
    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    .scrollContentBackground(.hidden)
    .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
    .scrollIndicators(.hidden)

    .background(ColorsApp.black)
  }
}

struct OldOrders_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteOrders(order: CartObservable())
      .environmentObject(StateNavigationTabView())
  }
}
