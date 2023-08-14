//
//  CustomButton.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 13/08/23.
//

import SwiftUI

struct CustomButtonAddOrMinusItens: View {
  var nameImage: String
  var action: () -> Void
  var body: some View {
    Button(action: { action() }, label: {
      Image(systemName: nameImage)
        .frame(width: 13, height: 10)
        .foregroundColor(ColorsApp.brown)
        .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
    })
    .background(ColorsApp.beige)
    .cornerRadius(4)
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonAddOrMinusItens(nameImage: "plus", action: {})
  }
}
