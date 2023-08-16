//
//  InputAddress.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//

import SwiftUI

struct InputAddress: View {
  func handle() {}

  var body: some View {
		VStack(alignment: .leading) {
      Button(action: handle) {
        Text("Insere seu endereço")
      }
      Divider()
        .frame(height: 1)
        .overlay(ColorsApp.black)
    }
    .frame(width: .infinity)
  }
}

struct InputAddress_Previews: PreviewProvider {
  static var previews: some View {
    InputAddress()
      .previewLayout(.sizeThatFits)
  }
}
