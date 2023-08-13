//
//  Cart.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct Cart: View {
  @ObservedObject var cart: CartObservable

  var body: some View {
    GeometryReader { geometry in

      if cart.cartOrder.isEmpty {
        ZStack {
          ColorsApp.black
            .ignoresSafeArea(.all)
          Text("Você não possui pedido")
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
              Order(order: coffee)
            }
          }
          .frame(minHeight: geometry.size.height * 0.73)
          Divider()
            .foregroundColor(ColorsApp.white)
            .frame(height: 3)
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
            .foregroundColor(ColorsApp.white)
            .frame(height: 3)
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
