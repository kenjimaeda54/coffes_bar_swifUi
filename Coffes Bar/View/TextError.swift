//
//  TextError.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import SwiftUI

struct TextError: View {
  var body: some View {
    Text("Desculpe, estamos com problemas ao carregar dados do servidor")
      .font(.custom(FontsApp.interLight, size: 16))
      .foregroundColor(ColorsApp.white)
  }
}

struct TextError_Previews: PreviewProvider {
  static var previews: some View {
    TextError()
  }
}
