//
//  SiginScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 21/08/23.
//

import SwiftUI

struct SiginScreen: View {
  @State private var isSheetPresentedEmail = false
  @State private var isSheetPresentedPassword = false
  @State private var nameIcon = "eye.slash.fill"
  @State private var email = ""
  @State private var password = ""
  @State private var isSheetPresented = false
  var passwordSecurity: String {
    var caracter = ""
    let arrayPassword = Array(repeating: "•", count: password.count)
    arrayPassword.forEach { caracter = "\(caracter)\($0)" }
    return caracter
  }

  // https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
  var validateEmail: Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return returnIsValiteField(value: email, pattern: pattern)
  }

  // https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
  // regex password
  var validatePassword: Bool {
    let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    return returnIsValiteField(value: password, pattern: pattern)
  }

  func returnIsValiteField(value: String, pattern: String) -> Bool {
    let range = NSRange(location: 0, length: value.utf16.count)
    do {
      let regexEmail = try NSRegularExpression(pattern: pattern)
      return regexEmail.firstMatch(in: value, range: range) != nil
    } catch {
      return false
    }
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        HStack {
          Text("Coffees")
            .font(.custom(FontsApp.pacificoRegular, size: 35))
            .foregroundColor(ColorsApp.white)
          Text("Bars")
            .font(.custom(FontsApp.pacificoRegular, size: 35))
            .foregroundColor(ColorsApp.white)
        }

        Button {
          isSheetPresented = true
        } label: {
          AsyncImage(url: URL(
            string: "https://firebasestorage.googleapis.com/v0/b/uploadimagesapicoffee.appspot.com/o/avatar01.png?alt=media&token=4a3820fa-b757-4bcd-b148-1cd914956112"
          ), scale: 7) { phase in

            if let image = phase.image {
              image
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)

            } else {
              Image("profile-default")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
            }
          }
        }
        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))

        ButtonTextFieldWithSheet(
          isSheetPresented: $isSheetPresentedEmail,
          textField: email, labelText: "Insira seu email"

        ) {
          TextFieldSheetDefault(
            placeHolderTextField: "Seu email",
            valueTextField: $email,
            isSheetPresented: $isSheetPresentedEmail,
            fieldValidate: email.count > 3 ? ValidateTextField(
              colorDefault: ColorsApp.gray,
              colorError: ColorsApp.red,
              isValid: validateEmail,
              feedBackWrong: validateEmail ? "" : "Coloque um emvail valido"
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
            secure: nameIcon == "eye.slash.fill",
            fieldValidate: password.count > 3 ? ValidateTextField(
              colorDefault: ColorsApp.gray,
              colorError: ColorsApp.red,
              isValid: validatePassword,
              feedBackWrong: validatePassword ? "" :
                "Senha precisa ser no mínimo 8 palavras, um maiúsculo, um dígito é um especial"
            ) : nil
          )
        }
      }
      .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
      .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
      .safeAreaInset(edge: .bottom, content: {
        CustomButtonDefault(handleButton: {}, width: .infinity, title: "Registrar", color: nil, textColor: nil)
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))

      })
      .background(
        ColorsApp.black
      )
      .sheet(isPresented: $isSheetPresented) {
        LazyVGrid(columns: gridItemAvatars, spacing: 15) {
          ForEach(avatarsMock) { avatars in
            RowAvatarImage(urlString: avatars.urlVatar)
          }
          .presentationDetents([.medium])
          .presentationBackground(ColorsApp.brown)
        }
      }
    }
  }
}

struct SiginScreen_Previews: PreviewProvider {
  static var previews: some View {
    SiginScreen()
  }
}
