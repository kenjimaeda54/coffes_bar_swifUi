//
//  LoginScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 19/08/23.
//

import SwiftUI

struct LoginScreen: View {
  @State private var isSheetPresentedEmail = false
  @State private var isSheetPresentedPassword = false
  @State private var nameIcon = "eye.slash.fill"
  @State private var email = ""
  @State private var password = ""
  var passwordSecurity: String {
    var caracter = ""
    let arrayPassword = Array(repeating: "•", count: password.count)
    arrayPassword.forEach { caracter = "\(caracter)\($0)" }
    return caracter
  }

  // https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
  var validateEmail: Bool {
    let range = NSRange(location: 0, length: email.utf16.count)
    do {
      let regexEmail = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
      return regexEmail.firstMatch(in: email, range: range) != nil
    } catch {
      return false
    }
  }

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Coffees")
          .font(.custom(FontsApp.pacificoRegular, size: 35))
          .foregroundColor(ColorsApp.white)
        Text("Bars")
          .font(.custom(FontsApp.pacificoRegular, size: 35))
          .foregroundColor(ColorsApp.white)
      }

      ButtonTextFieldWithSheet(
        isSheetPresented: $isSheetPresentedEmail,
        textField: email, labelText: "Insira seu email"

      ) {
        TextFieldSheetDefault(
          placeHolderTextField: "Seu email",
          valueTextField: $email,
          isSheetPresented: $isSheetPresentedEmail,
          fieldValidate: email.count > 3 ? ValidateField(
            colorDefault: ColorsApp.gray,
            colorError: ColorsApp.red,
            isValid: validateEmail,
            feedBackCorrect: "",
            feedBackWrong: "Coloque um emvail valido"
          ) : nil
        )
      }
      .keyboardType(.emailAddress)
      .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))

      ButtonTextFieldWithSheet(
        isSheetPresented: $isSheetPresentedPassword,
        textField: nameIcon == "eye.slash.fill" ? passwordSecurity : password,
        labelText: "Insira senha"

      ) {
        TextFieldSecurySheetWithIcon(
          placeHolderTextField: "Sua senha",
          valueTextField: $password,
          isSheetPresented: $isSheetPresentedPassword,
          nameIcon: nameIcon,
          action: {
            nameIcon = nameIcon == "eye.slash.fill" ? "eye.fill" : "eye.slash.fill"
          },
          secure: nameIcon == "eye.slash.fill"
        )
      }
    }
    .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    .safeAreaInset(edge: .bottom, content: {
      VStack {
        CustomButtonDefault(handleButton: {}, width: .infinity, title: "Seguir", color: nil, textColor: nil)
        Button(action: {}) {
          Text("Se não possui senha clique aqui")
        }
      }
      .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    })
    .background(
      ColorsApp.black
    )
  }
}
