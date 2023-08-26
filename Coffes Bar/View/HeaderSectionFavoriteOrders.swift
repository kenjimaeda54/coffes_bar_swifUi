//
//  HeaderSectionFavoriteOrders.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import SwiftUI

struct HeaderSectionFavoriteOrders: View {
  let valueTotalCart: Double

  var formatValueTotal: String {
    return String(format: "%.2f", valueTotalCart).replacingOccurrences(of: ".", with: ",")
  }

  var body: some View {
    HStack {
      Text("Valor total:")
        .font(.custom(FontsApp.interRegular, size: 21))
        .foregroundColor(ColorsApp.white)
      Text(formatValueTotal)
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
    HeaderSectionFavoriteOrders(valueTotalCart: 14.00)
  }
}
