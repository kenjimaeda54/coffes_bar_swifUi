//
//  CustomButtonPay.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 13/08/23.
//

import SwiftUI

struct CustomButtonPay: View {
  let handleButton: () -> Void
  let width: CGFloat
  let title: String
  let color: Color?
  let textColor: Color?

  var body: some View {
    Button {
      handleButton()
    } label: {
      Text(title)
        .font(.custom(FontsApp.interMedium, size: 20))
        .foregroundColor(textColor ?? ColorsApp.brown)
        .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
    }
    // se não funfar width tenta o maxwidth
    .frame(maxWidth: .infinity)
    .background(
      color ?? ColorsApp.beige
    )
    .cornerRadius(10)
  }
}

struct CustomButtonPay_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonPay(
      handleButton: {},
      width: .infinity,
      title: "Pagar agora",
      color: ColorsApp.beige,
      textColor: ColorsApp.brown
    )
    .previewLayout(.sizeThatFits)
  }
}
