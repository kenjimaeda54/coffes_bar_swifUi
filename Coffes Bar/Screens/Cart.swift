//
//  Cart.swift
//  Coffes Bar
// 5//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct Cart: View {
  @ObservedObject var cart: CartObservable
  @State private var tax = Double.random(in: 1..<7)
  @State private var valueTotalCart: Double = 0
  @State private var idCoffeeSelected = "1"
  @State private var offsetAnimated: CGFloat = 0.0
  @State private var goWhenTrue = false
  let user: UsersModel
  @Environment(\.dismiss) var dimiss
  @EnvironmentObject var stateTabView: StateNavigationTabView
  @StateObject var stateStackView = StateNavigationStack()
  // criei um objeto que vai ser compartilhado com todas as stack pra poder conseguir eliminar todas de uma vez

  func handlePlusQuantity(_ coffee: OrdersModel) {
    let newOrder = cart.cartOrder.map {
      if $0.id == coffee.id && $0.quantity < 50 {
        let newQuantity = $0.quantity + 1
        valueTotalCart += conveterStringCurrencyInDouble($0.price)
        let newOrder = OrdersModel(
          id: $0.id,
          urlPhoto: $0.urlPhoto,
          quantity: newQuantity,
          price: $0.price,
          name: $0.name
        )

        return newOrder
      }
      return $0
    }

    cart.cartOrder = newOrder
  }

  func handleMinusQuantity(_ coffee: OrdersModel) {
    let newOrder = cart.cartOrder.map {
      if $0.id == coffee.id && $0.quantity > 1 {
        let newQuantity = $0.quantity - 1
        valueTotalCart -= conveterStringCurrencyInDouble($0.price)
        let newOrder = OrdersModel(
          id: $0.id,
          urlPhoto: $0.urlPhoto,
          quantity: newQuantity,
          price: $0.price,
          name: $0.name
        )

        return newOrder
      }
      return $0
    }

    cart.cartOrder = newOrder
  }

  var body: some View {
    GeometryReader { geometry in
      NavigationStack {
        if cart.cartOrder.isEmpty {
          ZStack {
            ColorsApp.black
              .ignoresSafeArea(.all)
            Text("Você não possui pedidos")
              .font(.custom(FontsApp.interBold, size: 20))
              .foregroundColor(ColorsApp.white)
              .foregroundColor(ColorsApp.white)
          }

        } else {
          ScrollView(showsIndicators: false) {
            Text("Carrinho")
              .font(.custom(FontsApp.interBold, size: 20))
              .foregroundColor(ColorsApp.white)
            VStack {
              // como pegar o index
              // https://alejandromp.com/blog/swiftui-enumerated/
              // no meu caso e melhor usar verificação de index, pois se não houver o index
              // não posso tentar remover
              ForEach(cart.cartOrder) { coffee in
                Order(
                  order: coffee,
                  handlePlusQuantity: { handlePlusQuantity(coffee) },
                  handleMinusQuantity: { handleMinusQuantity(coffee) },
                  removal: {
                    if let index = cart.cartOrder.firstIndex(where: { $0.id == coffee.id }) {
                      let order = cart.cartOrder.remove(at: index)
                      valueTotalCart -= (conveterStringCurrencyInDouble(order.price) * Double(order.quantity))
                    }
                  }
                )
                .offset(x: idCoffeeSelected == coffee.id ? offsetAnimated : 0)
                .animation(.spring(), value: true)
              }
            }
            // para alinhar no topo usa dentro do frame
            .frame(minHeight: geometry.size.height * 0.70, alignment: .top)
            Spacer()
            Divider()
              .frame(height: 1)
              .overlay(ColorsApp.white.opacity(0.2))

            OverviewPayment(tax: tax, value: valueTotalCart)

            CustomButtonDefault(
              handleButton: { stateStackView.isActiveFinishPayment = true },
              width: .infinity,
              title: "Finalizar compra",
              color: nil,
              textColor: nil
            )
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
            // sempre que navega fica ativo por isso criei um observableobject
            // na ultim tela que e PurchaseScreeen elimino todas as views ativas
            .navigationDestination(isPresented: $stateStackView.isActiveFinishPayment) {
              FinishPaymentScreen(cart: cart, tax: tax, valueTotalCart: valueTotalCart, userId: user.id)
            }
          }
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          .frame(width: .infinity)
          .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
          .onAppear {
            valueTotalCart = cart.cartOrder
              .reduce(0) { $0 + (conveterStringCurrencyInDouble($1.price) * Double($1.quantity)) }
            stateTabView.hiddeTabView = false
          }
        }
      }
      .environmentObject(stateStackView)
    }
  }
}

struct Cart_Previews: PreviewProvider {
  static var previews: some View {
    Cart(cart: CartObservable(), user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""))
      .environmentObject(StateNavigationTabView())
  }
}
