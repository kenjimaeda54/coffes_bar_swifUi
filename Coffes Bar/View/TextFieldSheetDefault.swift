//
//  TextFielSheetdDefault.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 20/08/23.
//

import SwiftUI

enum Field: Int, Hashable {
  case message
}

struct ValidateField {
  let colorDefault: Color
  let colorError: Color
  let isValid: Bool
  let feedBackCorrect: String
  let feedBackWrong: String
  init(colorDefault: Color, colorError: Color, isValid: Bool, feedBackCorrect: String, feedBackWrong: String) {
    self.colorDefault = colorDefault
    self.colorError = colorError
    self.isValid = isValid
    self.feedBackCorrect = feedBackCorrect
    self.feedBackWrong = feedBackWrong
  }
}

struct TextFieldSheetDefault: View {
  let placeHolderTextField: String
  @Binding var valueTextField: String
  @FocusState var focusedField: Field?
  @Binding var isSheetPresented: Bool
  var fieldValidate: ValidateField?

  var body: some View {
    VStack(spacing: 2) {
      // Abaixo uma maneira de pegar o retorno do keyboard usando axis vertical
      TextField(placeHolderTextField, text: Binding(
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
        .onAppear {
          focusedField = .message
        }
        .submitLabel(.done)

      if fieldValidate != nil {
        Text(fieldValidate!.isValid ? fieldValidate!.feedBackCorrect : fieldValidate!.feedBackWrong)
          .font(.custom(FontsApp.interLight, size: 16))
          .foregroundColor(fieldValidate!.isValid ? fieldValidate!.colorDefault : fieldValidate!.colorError)
          .padding(EdgeInsets(top: 5, leading: 0, bottom: 30, trailing: 0))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

struct TextFieldDefault_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldSheetDefault(
      placeHolderTextField: "Rua",
      valueTextField: .constant(""),
      isSheetPresented: .constant(false),
      fieldValidate: nil
    )
  }
}
