//
//  Order.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 11/08/23.
//

import SwiftUI

struct Order: View {
  let order: CartOderModel
  let handlePlusQuantity: () -> Void
  let handleMinusQuantity: () -> Void

  var body: some View {
    HStack(spacing: 20) {
      AsyncImage(url: URL(string: order.urlPhoto), scale: 8)
        .scaledToFill()
        .cornerRadius(8)

      VStack(alignment: .leading) {
        Text(order.name)
          .font(.custom(FontsApp.interMedium, size: 18))
          .foregroundColor(ColorsApp.white)
          .lineLimit(2)

        Spacer()
        Text(order.price)
          .font(.custom(FontsApp.interRegular, size: 18))
          .foregroundColor(ColorsApp.white)
      }
      Spacer()
      HStack(spacing: 4) {
        CustomButtonAddOrMinusItens(nameImage: "minus", action: handleMinusQuantity)

        Text("\(order.quantity)")
          .font(.custom(FontsApp.interLight, size: 14))
          .foregroundColor(ColorsApp.beige)
          .frame(width: 20)

        CustomButtonAddOrMinusItens(nameImage: "plus", action: handlePlusQuantity)
      }
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 7, trailing: 7))
    .background(ColorsApp.brown)
    .cornerRadius(5)
    .frame(height: 100)
  }
}

struct Order_Previews: PreviewProvider {
  static var previews: some View {
    Order(order: cartOderMock[0], handlePlusQuantity: {}, handleMinusQuantity: {})
      .previewLayout(.sizeThatFits)
  }
}
