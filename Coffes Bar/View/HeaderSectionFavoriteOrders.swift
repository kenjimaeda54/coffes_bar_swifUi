//
//  HeaderSectionFavoriteOrders.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import SwiftUI

struct HeaderSectionFavoriteOrders: View {
  var body: some View {
    HStack {
      Text("Valor total:")
        .font(.custom(FontsApp.interRegular, size: 21))
        .foregroundColor(ColorsApp.white)
      Text("R$14")
        .font(.custom(FontsApp.interMedium, size: 21))
        .foregroundColor(ColorsApp.white)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .offset(x: -20)
  }
}

struct HeaderSectionFavoriteOrders_Previews: PreviewProvider {
  static var previews: some View {
    HeaderSectionFavoriteOrders()
  }
}
