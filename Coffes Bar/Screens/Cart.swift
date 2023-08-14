//
//  Cart.swift
//  Coffes Bar
// 5//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct Cart: View {
  @ObservedObject var cart: CartObservable

  func handlePlusQuantity(_ coffee: CartOderModel) {
    let newOrder = cart.cartOrder.map {
      if $0.id == coffee.id && $0.quantity < 50 {
        let newQuantity = $0.quantity + 1
        let newOrder = CartOderModel(
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

  func handleMinusQuantity(_ coffee: CartOderModel) {
    let newOrder = cart.cartOrder.map {
      if $0.id == coffee.id && $0.quantity > 1 {
        let newQuantity = $0.quantity - 1
        let newOrder = CartOderModel(
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
            ForEach(cart.cartOrder) { coffee in
              Order(
                order: coffee,
                handlePlusQuantity: { handlePlusQuantity(coffee) },
                handleMinusQuantity: { handleMinusQuantity(coffee) }
              )
            }
          }
          // para alinhar no topo usa dentro do frame
          .frame(minHeight: geometry.size.height * 0.70, alignment: .top)
          Spacer()
          Divider()
            .frame(height: 1)
            .overlay(ColorsApp.white.opacity(0.2))

          HStack {
            Text("Taxa de entrega")
              .font(.custom(FontsApp.interRegular, size: 17))
              .foregroundColor(ColorsApp.white)
            Spacer()
            Text("R$ 6.50")
              .font(.custom(FontsApp.interBold, size: 19))
              .foregroundColor(ColorsApp.white)
          }
          HStack {
            Text("Valor total")
              .font(.custom(FontsApp.interRegular, size: 17))
              .foregroundColor(ColorsApp.white)
            Spacer()
            Text("R$ 17.50")
              .font(.custom(FontsApp.interBold, size: 19))
              .foregroundColor(ColorsApp.white)
          }
          Divider()
            .frame(minHeight: 1)
            .overlay(ColorsApp.white.opacity(0.2))

          CustomButtonPay(handleButton: {}, width: .infinity, title: "Pagar agora")
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .frame(width: .infinity)
        .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
      }
    }
  }
}

struct Cart_Previews: PreviewProvider {
  static var previews: some View {
    Cart(cart: CartObservable())
  }
}
