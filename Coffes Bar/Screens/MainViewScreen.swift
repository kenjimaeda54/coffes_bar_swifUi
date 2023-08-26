//
//  MainView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import PartialSheet
import SwiftUI

struct MainViewScreen: View {
  @ObservedObject var cartOders = CartObservable()
  @StateObject var stateTabView = StateNavigationTabView()
  var user: UsersModel

  var body: some View {
    // maneira de navegar via codigo entre as tabs
    // alem de fazer as tagas criei um objeto que e compartilhado entre todas as views
    TabView(selection: $stateTabView.tagSelected) {
      HomeScreen(cart: cartOders, user: user)
        .tabItem {
          Image(systemName: "house.fill")
        }

        .toolbar(stateTabView.hiddeTabView ? .hidden : .visible, for: .tabBar)
        .tag(0)

      Cart(cart: cartOders, user: user)

          .tabItem {
            Image(systemName: "cart.fill")
          }
          .tag(1)

      FavoriteOrders(order: cartOders, user: user)
        .tabItem {
          Image(systemName: "heart.fill")
        }
        .tag(2)
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
    .environmentObject(stateTabView)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainViewScreen(user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""))
      .environmentObject(StateNavigationTabView())
  }
}
