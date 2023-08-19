//
//  SheetTextField.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 17/08/23.
//

import SwiftUI

enum Field: Int, Hashable {
  case message
}

struct SheetTextField: View {
  // https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-textfield-or-texteditor-have-default-focus
  // aplicar focus, exemplo acima e bem complexo seriam varios campos com focus
  @Binding var valueTextField: String
  @FocusState private var focusedField: Field?
  let titleSheetPresented: String
  @Binding var isSheetPresented: Bool

  var body: some View {
    VStack {
      VStack(alignment: .center, spacing: 10) {
        // Abaixo uma maneira de usar de pegar o retorno do keyboard usando axis vertical
        TextField(titleSheetPresented, text: Binding(
          get: { valueTextField },
          set: { newValue, _ in
            if let _ = newValue.lastIndex(of: "\n") {
              focusedField = .none
              isSheetPresented = false

            } else {
              valueTextField = newValue
            }
          }
        ), axis: .vertical)
          .font(.custom(FontsApp.interRegular, size: 18))
          .foregroundColor(ColorsApp.black)

          .focused($focusedField, equals: .message)
          .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
          .background(
            RoundedRectangle(cornerRadius: 7)
              .stroke(ColorsApp.gray, lineWidth: 1)
          )
          .submitLabel(.done)
      }
    }
    .frame(height: 100, alignment: .center)
    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
    .onAppear {
      focusedField = .message
    }
  }
}

struct SheetTextField_Previews: PreviewProvider {
  static var previews: some View {
    SheetTextField(valueTextField: .constant(""), titleSheetPresented: "Rua", isSheetPresented: .constant(false))
  }
}
