//
//  InputAddress.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//
import PartialSheet
import SwiftUI

struct ButtonTextFieldWithSheet<Content: View>: View {
  // exemplo como passar uma view pro Swiftui
  @Binding var isSheetPresented: Bool
  var textField: String
  let labelText: String
  let viewSheet: () -> Content

  var body: some View {
    Button(action: {
      isSheetPresented = true
    }, label: {
      Text(textField.isEmpty ? labelText : textField)
        .foregroundColor(ColorsApp.gray)
        .font(.custom(FontsApp.interLight, size: 17))
        .frame(maxWidth: .infinity, alignment: .leading)
        .lineLimit(1)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .overlay(
          Divider()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .background(ColorsApp.white.opacity(0.5)),
          alignment: .bottom
        )

    })
    .sheet(isPresented: $isSheetPresented) {
      viewSheet()
        .presentationDetents([.fraction(0.15)])
        .presentationDragIndicator(.hidden)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
  }
}

struct InputAddress_Previews: PreviewProvider {
  static var previews: some View {
    ButtonTextFieldWithSheet(
      isSheetPresented: .constant(false),
      textField: "Coloque nome da rua", labelText: "Coloque nome da arua", viewSheet: {
        Text("View builder")
      }
    )
  }
}
