//
//  CustomButton.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 13/08/23.
//

import SwiftUI

struct CustomButtonAddOrMinusItens: View {
  var nameImage: String
  var body: some View {
    Button(action: {}, label: {
      Image(systemName: nameImage)
        .frame(width: 20, height: 15)
        .foregroundColor(ColorsApp.brown)
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
    })
    .background(ColorsApp.beige)
    .cornerRadius(5)
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonAddOrMinusItens(nameImage: "plus")
  }
}
