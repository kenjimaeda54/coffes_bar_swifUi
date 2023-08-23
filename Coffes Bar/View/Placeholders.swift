//
//  Placeholders.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 22/08/23.
//

import SwiftUI

struct PlaceholderAvatar: View {
  var body: some View {
    Image("profile-default")
      .resizable()
      .frame(width: 80, height: 80)
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
      .redactShimmer(condition: true)
      .foregroundColor(ColorsApp.white.opacity(0.5))
  }
}

struct Placeholders_Previews: PreviewProvider {
  static var previews: some View {
    PlaceholderAvatar()
  }
}

struct PlaceholderListCoffe: View {
  @ObservedObject var cart: CartObservable

  var body: some View {
    LazyVGrid(columns: gridItemCoffee) {
      ForEach(coffeesMock) { coffee in
        CoffeeItem(
          coffee: coffee, order: cart,
          handleSelectedCoffee: {}
        )
      }
    }
    .redactShimmer(condition: true)
    .foregroundColor(ColorsApp.white)
  }
}
