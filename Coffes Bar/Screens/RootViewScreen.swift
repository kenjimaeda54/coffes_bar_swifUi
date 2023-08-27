//
//  RootViewScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 22/08/23.
//

import SwiftUI

struct RootViewScreen: View {
  // Tentar inserir user via enviroment
  @State private var isLoggedIn = false
  @State private var user = UsersModel(id: "", name: "", email: "", avatarId: "", password: "")

  var body: some View {
    if isLoggedIn {
      MainViewScreen(user: user, isLoggedIn: $isLoggedIn)
    } else {
      LoginScreen(isLoged: $isLoggedIn, user: $user)
    }
  }
}

struct RootViewScreen_Previews: PreviewProvider {
  static var previews: some View {
    RootViewScreen()
  }
}
