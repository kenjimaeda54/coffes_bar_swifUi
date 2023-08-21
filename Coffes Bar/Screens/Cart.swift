//
//  Cart.swift
//  Coffes Bar
// 5//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct Cart: View {
  @ObservedObject var cart: CartObservable
  @State private var tax = Double.random(in: 1..<7)
  @State private var value: Double = 0
  @State private var idCoffeeSelected = "1"
  @State private var offsetAnimated: CGFloat = 0.0
  @State private var goWhenTrue = false
  @Environment(\.dismiss) var dimiss
  @EnvironmentObject var stateTabView: StateNavigationTabView
  // criei um objeto que vai ser compartilhado com todas as stack pra poder conseguir eliminar todas de uma vez
  @StateObject var stateStackView = StateNavigationStack()

  func conveterStringCurrencyInDouble(_ value: String) -> Double {
    // replace string https://www.tutorialspoint.com/swift-program-to-replace-a-character-at-a-specific-index#:~:text=Method%203%3A%20Using%20the%20replacingCharacters,by%20the%20given%20replacement%20character.
    // number foramt currency
    // https://medium.com/@mariannM/currency-converter-in-swift-4-2-97384a56da41
    let stringSplitComma = value.split(separator: ",")
    let stringSplitSymbol = stringSplitComma[0].split(separator: " ")
    let stringSlpited = "\(stringSplitSymbol[1]).\(stringSplitComma[1])"
    return Double(stringSlpited) ?? 0.0
  }

  func handlePlusQuantity(_ coffee: OrdersModel) {
    let newOrder = cart.cartOrder.map {
      if $0.id == coffee.id && $0.quantity < 50 {
        let newQuantity = $0.quantity + 1
        value += conveterStringCurrencyInDouble($0.price)
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
        value -= conveterStringCurrencyInDouble($0.price)
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
    NavigationStack {
      GeometryReader { geometry in
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
                      value -= (conveterStringCurrencyInDouble(order.price) * Double(order.quantity))
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

            OverviewPayment(tax: tax, value: value)

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
              FinishPaymentScreen(cart: cart, tax: tax, value: value)
            }
          }
          .onAppear {
            stateStackView.isActiveFinishPayment = false
          }
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
          .frame(width: .infinity)
          .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
          .onAppear {
            value = cart.cartOrder.reduce(0) { $0 + (conveterStringCurrencyInDouble($1.price) * Double($1.quantity)) }
            stateTabView.hiddeTabView = false
          }
          .environmentObject(stateStackView)
        }
      }
    }
  }
}

struct Cart_Previews: PreviewProvider {
  static var previews: some View {
    Cart(cart: CartObservable())
      .environmentObject(StateNavigationTabView())
      .environmentObject(StateNavigationStack())
  }
}
