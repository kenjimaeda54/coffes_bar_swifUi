//
//  RowDescription.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 17/08/23.
//

import SwiftUI

struct RowDescription: View {
  let name: String
  let value: String

  var body: some View {
    HStack {
      Text(name)
        .font(.custom(FontsApp.interLight, size: 20))
        .foregroundColor(ColorsApp.black)
      Spacer()
      Text(value)
        .font(.custom(FontsApp.interRegular, size: 20))
        .foregroundColor(ColorsApp.black)
    }
    .overlay(
      Divider()
        .frame(maxWidth: .infinity, maxHeight: 1)
        .background(ColorsApp.black.opacity(0.5)),
      alignment: .bottom
    )
  }
}

struct RowDescription_Previews: PreviewProvider {
  static var previews: some View {
    RowDescription(name: "Cafe expresso", value: "R$ 6.50")
  }
}
