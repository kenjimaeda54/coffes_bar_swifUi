//
//  SheetTextField.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 17/08/23.
//

import SwiftUI

struct SheetTextField: View {
  // https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-textfield-or-texteditor-have-default-focus
  // aplicar focus
  @Binding var valueTextField: String
  @FocusState private var focusedField: FocusedField?
  let titleSheetPresented: String

  var body: some View {
    VStack {
      VStack(alignment: .center, spacing: 10) {
        TextField(titleSheetPresented, text: $valueTextField, axis: .vertical)
          .font(.custom(FontsApp.interRegular, size: 18))
          .foregroundColor(ColorsApp.black)
          .focused($focusedField, equals: .firstInput)
          .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
          .background(
            RoundedRectangle(cornerRadius: 7)
              .stroke(ColorsApp.gray, lineWidth: 1)
          )
      }
    }
    .frame(height: 100, alignment: .center)
    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
    .onAppear {
      focusedField = .firstInput
    }
  }
}

struct SheetTextField_Previews: PreviewProvider {
  static var previews: some View {
    SheetTextField(valueTextField: .constant(""), titleSheetPresented: "Rua")
  }
}
