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
  @StateObject private var storeOrders = StoreOrders()
  var user: UsersModel
  // depois clonar os dois
  // https://www.hackingwithswift.com/example-code/language/how-to-append-one-array-to-another-array
  @State private var auxiliaryUpdateOrder: [OrdersModel] = []
  @State private var auxiliaryOrder: [OrdersModel] = []
  @State private var valueTotalCart = ""

  func selectedOrder(_ orders: [Orders]) {
    orders.forEach { orders in
      if let index = order.cartOrder.firstIndex(where: { $0.id == orders.coffeeId }) {
        let orderRemoved = order.cartOrder.remove(at: index)
        let order = OrdersModel(
          id: orders.coffeeId,
          urlPhoto: orders.urlImage,
          quantity: orders.quantity + orderRemoved.quantity,
          price: orders.price,
          name: orders.title
        )
        auxiliaryUpdateOrder.append(order)

      } else {
        let order = OrdersModel(
          id: orders.coffeeId,
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
    if storeOrders.orderByUser.isEmpty {
      VStack(alignment: .center) {
        Text("Sem nehum pedido anterior")
          .font(.custom(FontsApp.interMedium, size: 20))
          .foregroundColor(ColorsApp.white)
      }
      .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
      .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      .background(ColorsApp.black)
      .onAppear {
        storeOrders.fetchAnOrderByUser(user.id)
      }
    } else {
      List {
        ForEach(storeOrders.orderByUser) { ordersGroup in

          Section {
            ForEach(ordersGroup.orders) { order in
              Button {
                selectedOrder(ordersGroup.orders)
              } label: {
                Order(
                  order: OrdersModel(
                    id: order.coffeeId,
                    urlPhoto: order.urlImage,
                    quantity: order.quantity,
                    price: order.price,
                    name: order.title
                  ),
                  handlePlusQuantity: {},
                  handleMinusQuantity: {}, removal: nil
                )
                .disabled(true)
              }
              .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
              .listRowBackground(ColorsApp.black)
            }

          } header: {
            HeaderSectionFavoriteOrders(
              valueTotalCart: conveterStringCurrencyInDouble(ordersGroup.priceCartTotal) +
                conveterStringCurrencyInDouble(ordersGroup.tax)
            )
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
      .onAppear {
        storeOrders.fetchAnOrderByUser(user.id)
      }
      .background(ColorsApp.black)
    }
  }
}

struct OldOrders_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteOrders(order: CartObservable(), user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""))
      .environmentObject(StateNavigationTabView())
  }
}
