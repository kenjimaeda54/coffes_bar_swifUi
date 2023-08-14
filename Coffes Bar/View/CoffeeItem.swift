//
//  CoffeeItem.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct CoffeeItem: View {
  let coffee: CoffeesModel
  @Binding var listIdSelected: [String]
  let handleSelectedCoffee: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      AsyncImage(url: URL(string: coffee.urlPhoto), scale: 8)
        .scaledToFit()
        .cornerRadius(5)
        .frame(minHeight: 80)

      Text(coffee.name)
        .lineLimit(2)
        .font(.custom(FontsApp.interLight, size: 17))
        .foregroundColor(listIdSelected.contains(coffee.id) ? ColorsApp.black : ColorsApp.white)
        .frame(height: 50)

      Button { handleSelectedCoffee() } label: {
        Text(coffee.price)
          .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 0))
          .font(.custom(FontsApp.interLight, size: 16))
          .foregroundColor(listIdSelected.contains(coffee.id) ? ColorsApp.black : ColorsApp.white)
        Spacer()
        ZStack {
          Image(systemName: listIdSelected.contains(coffee.id) ? "minus" : "plus")
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
            .foregroundColor(listIdSelected.contains(coffee.id) ? ColorsApp.beige : ColorsApp.brown)
        }
        .frame(width: 30, height: 30)
        .scaledToFit()
        .background(listIdSelected.contains(coffee.id) ? ColorsApp.brown : ColorsApp.beige)
        .cornerRadius(7)
      }
      .background(ColorsApp.gray)
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      .cornerRadius(7)
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 7, trailing: 7))
    .background(listIdSelected.contains(coffee.id) ? ColorsApp.beige : ColorsApp.brown)
    .cornerRadius(5)
    .frame(width: 130, height: 250)
  }
}

struct CoffeeItem_Previews: PreviewProvider {
  static var previews: some View {
    CoffeeItem(coffee: coffeesMock[3], listIdSelected: .constant([""]), handleSelectedCoffee: {})
      .previewLayout(.device)
  }
}