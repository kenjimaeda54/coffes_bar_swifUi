//
//  MainView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI

struct MainView: View {
  @ObservedObject var cartOders = CartObservable()

  var body: some View {
    TabView {
      HomeScreen(cart: cartOders)
        .tabItem {
          Image(systemName: "house.fill")
        }

      Cart(cart: cartOders)
        .tabItem {
          Image(systemName: "cart.fill")
        }

      FavoriteOrders()
        .tabItem {
          Image(systemName: "heart.fill")
        }
    }
    .edgesIgnoringSafeArea(.all)
    // tint color e icone selecionado
    .tint(ColorsApp.beige)

    .onAppear {
      let standardAppearance = UITabBarAppearance()
      standardAppearance.configureWithDefaultBackground()
      standardAppearance.backgroundColor = UIColor(
        displayP3Red: 57 / 255,
        green: 38 / 255,
        blue: 41 / 255,
        alpha: 1
      )
      UITabBar.appearance().standardAppearance = standardAppearance
      let scrollEdgeAppearance = UITabBarAppearance()
      scrollEdgeAppearance.configureWithTransparentBackground()
      UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
      scrollEdgeAppearance.backgroundColor = UIColor(
        displayP3Red: 57 / 255,
        green: 38 / 255,
        blue: 41 / 255,
        alpha: 1
      )
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
