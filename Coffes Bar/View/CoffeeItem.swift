//
//  CoffeeItem.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct CoffeeItem: View {
  let coffee: CoffeesModel
  @State private var isSelectedCoffee = false

  func handleSelectedCoffee() {
    isSelectedCoffee = !isSelectedCoffee
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      AsyncImage(url: URL(string: coffee.urlPhoto), scale: 8)
        .scaledToFit()
        .cornerRadius(5)
        .frame(minHeight: 80)

      Text(coffee.name)
        .lineLimit(2)
        .font(.custom(FontsApp.interLight, size: 17))
        .foregroundColor(isSelectedCoffee ? ColorsApp.black : ColorsApp.white)
        .frame(height: 50)

      Button { handleSelectedCoffee() } label: {
        Text(coffee.price)
          .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 0))
          .font(.custom(FontsApp.interLight, size: 16))
          .foregroundColor(isSelectedCoffee ? ColorsApp.black : ColorsApp.white)
        Spacer()
        ZStack {
          Image(systemName: isSelectedCoffee ? "minus" : "plus")
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
            .foregroundColor(isSelectedCoffee ? ColorsApp.beige : ColorsApp.brown)
        }
        .frame(width: 30, height: 30)
        .scaledToFit()
        .background(isSelectedCoffee ? ColorsApp.brown : ColorsApp.beige)
        .cornerRadius(7)
      }
      .background(ColorsApp.gray)
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      .cornerRadius(7)
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 7, trailing: 7))
    .background(isSelectedCoffee ? ColorsApp.beige : ColorsApp.brown)
    .cornerRadius(5)
    .frame(width: 130, height: 250)
  }
}

struct CoffeeItem_Previews: PreviewProvider {
  static var previews: some View {
    CoffeeItem(coffee: coffeesMock[3])
      .previewLayout(.device)
  }
}
