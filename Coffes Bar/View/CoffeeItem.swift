//
//  CoffeeItem.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI
import URLImage

struct CoffeeItem: View {
  let coffee: CoffeesModel
  @ObservedObject var order: CartObservable
  let handleSelectedCoffee: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      AsyncImage(url: URL(string: coffee.urlPhoto), scale: 8) { phase in

        if let image = phase.image {
          image
            .resizable()
            .scaledToFit()
            .cornerRadius(10, corners: .allCorners)
            .frame(width: .infinity, height: 100)
        }
      }

      Text(coffee.name)
        .lineLimit(2)
        .fontWithLineHeight(font: UIFont(name: FontsApp.interRegular, size: 17)!, lineHeight: 23)
        .foregroundColor(order.cartOrder.contains(where: { $0.id == coffee.id }) ? ColorsApp.black : ColorsApp.white)
        // quando possuir multiplas linhas precisa disso
        .multilineTextAlignment(.leading)
        .frame(height: 50, alignment: .leading)

      Button { handleSelectedCoffee() } label: {
        Text(coffee.price)
          .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 0))
          .font(.custom(FontsApp.interLight, size: 16))
          .foregroundColor(order.cartOrder.contains(where: { $0.id == coffee.id }) ? ColorsApp.black : ColorsApp.white)
        Spacer()
        ZStack {
          Image(systemName: order.cartOrder.contains(where: { $0.id == coffee.id }) ? "minus" : "plus")
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
            .foregroundColor(
              order.cartOrder.contains(where: { $0.id == coffee.id }) ? ColorsApp.beige : ColorsApp
                .brown
            )
        }
        .frame(width: 30, height: 30)
        .scaledToFit()
        .background(order.cartOrder.contains(where: { $0.id == coffee.id }) ? ColorsApp.brown : ColorsApp.beige)
        .cornerRadius(7)
      }
      .background(ColorsApp.gray)
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      .cornerRadius(7)
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 7, trailing: 7))
    .background(order.cartOrder.contains(where: { $0.id == coffee.id }) ? ColorsApp.beige : ColorsApp.brown)
    .cornerRadius(5)
    .frame(width: 130, height: 250, alignment: .leading)
  }
}

struct CoffeeItem_Previews: PreviewProvider {
  static var previews: some View {
    CoffeeItem(coffee: coffeesMock[0], order: CartObservable(), handleSelectedCoffee: {})
      .previewLayout(.device)
  }
}
