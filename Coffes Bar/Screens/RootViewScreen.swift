//
//  RootViewScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 22/08/23.
//

import SwiftUI

struct RootViewScreen: View {
  @State private var isLoggedIn = false

  var body: some View {
    if isLoggedIn {
      MainViewScreen()
    } else {
      LoginScreen(isLoged: $isLoggedIn)
    }
  }
}

struct RootViewScreen_Previews: PreviewProvider {
  static var previews: some View {
    RootViewScreen()
  }
}
