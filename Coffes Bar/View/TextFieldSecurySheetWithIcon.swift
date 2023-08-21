//
//  TextFieldSheetWithIcon.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 20/08/23.
//

import SwiftUI

struct TextFieldSecurySheetWithIcon: View {
  let placeHolderTextField: String
  @Binding var valueTextField: String
  @FocusState var focusedField: Field?
  @Binding var isSheetPresented: Bool
  let nameIcon: String
  let action: (() -> Void)?
  let secure: Bool
  var fieldValidate: ValidateTextField?

  var body: some View {
    VStack(spacing: 2) {
      ZStack(alignment: .leading) {
        Button {
          action?()
        } label: {
          Image(systemName: nameIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .offset(x: 20)
            .foregroundColor(ColorsApp.black)
        }

        if secure {
          SecureField(placeHolderTextField, text: self.$valueTextField.max(16))
            .font(.custom(FontsApp.interRegular, size: 18))
            .foregroundColor(ColorsApp.black)
            .focused($focusedField, equals: .message)
            .padding(EdgeInsets(top: 7, leading: 60, bottom: 7, trailing: 10))
            .background(
              RoundedRectangle(cornerRadius: 7)
                .stroke(ColorsApp.gray, lineWidth: 1)
            )
            .onAppear {
              focusedField = .message
            }
            .submitLabel(.done)
        } else {
          TextField(placeHolderTextField, text: self.$valueTextField.max(16))
            .font(.custom(FontsApp.interRegular, size: 18))
            .foregroundColor(ColorsApp.black)
            .focused($focusedField, equals: .message)
            .padding(EdgeInsets(top: 7, leading: 60, bottom: 7, trailing: 10))
            .background(
              RoundedRectangle(cornerRadius: 7)
                .stroke(ColorsApp.gray, lineWidth: 1)
            )
            .onAppear {
              focusedField = .message
            }
            .submitLabel(.done)
        }
      }
      if fieldValidate != nil {
        Text(fieldValidate!.feedBackWrong)
          .font(.custom(FontsApp.interLight, size: 16))
          .foregroundColor(fieldValidate!.isValid ? fieldValidate!.colorDefault : fieldValidate!.colorError)
          .padding(EdgeInsets(top: 5, leading: 0, bottom: 30, trailing: 0))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

struct TextFieldSheetWithIcon_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldSecurySheetWithIcon(
      placeHolderTextField: "Rua",
      valueTextField: .constant(""),
      isSheetPresented: .constant(false),
      nameIcon: "lock",
      action: nil,
      secure: false,
      fieldValidate: nil
    )
  }
}
