//
//  InputAddress.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//
import PartialSheet
import SwiftUI

struct InputAddress: View {
  // exemplo como passar uma view pro Swiftui
  @Binding var isSheetPresented: Bool
  @State private var textField = ""
  let labelText: String

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
      SheetTextField(
        valueTextField: $textField,
        titleSheetPresented: textField.isEmpty ? labelText : textField, isSheetPresented: $isSheetPresented
      )
      .presentationDetents([.fraction(0.15)])
      .presentationDragIndicator(.hidden)
    }
  }
}

struct InputAddress_Previews: PreviewProvider {
  static var previews: some View {
    InputAddress(isSheetPresented: .constant(false), labelText: "Coloque nome da arua")
  }
}
