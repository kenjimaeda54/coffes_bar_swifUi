//
//  InputAddress.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//

import PartialSheet
import SwiftUI

enum FocusedField {
  case firstInput
}

struct InputAddress<Content: View>: View {
	//exemplo como passar uma view pro Swiftui
  let viewBuilder: () -> Content

  func handle() {}

  var body: some View {
    VStack(alignment: .leading) {
      viewBuilder()
      Divider()
        .frame(height: 1)
        .overlay(ColorsApp.white)
    }
    .frame(width: .infinity)
  }
}

struct InputAddress_Previews: PreviewProvider {
  static var previews: some View {
    InputAddress {
      Button(action: {}) {
        Text("Insira o endereço")
          .font(.custom(FontsApp.interLight, size: 17))
          .foregroundColor(ColorsApp.gray)
      }
    }
  }
}

struct SheetTextFieldView: View {
  @State private var text: String = ""
  @FocusState private var focusedField: FocusedField?
  // https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-textfield-or-texteditor-have-default-focus
  // aplicar focus
  var body: some View {
    VStack {
      VStack(alignment: .center, spacing: 10) {
        TextField("Address", text: self.$text)
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
