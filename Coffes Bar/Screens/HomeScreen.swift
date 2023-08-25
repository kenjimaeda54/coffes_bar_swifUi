//
//  ContentView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 09/08/23.
//

import SwiftUI

struct HomeScreen: View {
  @State private var searchMovie = ""
  @ObservedObject var cart: CartObservable
  @EnvironmentObject private var stateTabView: StateNavigationTabView
  @State private var isSheetPresented = false
  @StateObject var storeCoffess = StoreCoffess()
  @StateObject var storeAvatars = StoreAvatar()
  var user: UsersModel

  func handleSelectedCoffee(_ itemSelected: CoffeesModel) {
    if cart.cartOrder.contains(where: { itemSelected.id == $0.id }) {
      let index = cart.cartOrder.firstIndex(where: { $0.id == itemSelected.id })
      cart.cartOrder.remove(at: index!)
    } else {
      let order = OrdersModel(
        id: itemSelected.id,
        urlPhoto: itemSelected.urlPhoto,
        quantity: 1,
        price: itemSelected.price,
        name: itemSelected.name
      )

      cart.cartOrder.append(order)
    }
  }

  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text("Coffees")
                .font(.custom(FontsApp.pacificoRegular, size: 27))
                .foregroundColor(ColorsApp.white)

              Text("Bars")
                .font(.custom(FontsApp.pacificoRegular, size: 32))
                .foregroundColor(ColorsApp.white)
            }
            Spacer()

            Button {
              isSheetPresented = true
            } label: {
              AsyncImage(url: URL(
                string: storeAvatars.avatarByUser.urlAvatar
              ), scale: 7) { phase in

                if let image = phase.image {
                  image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fit)

                } else {
                  PlaceholderAvatar()
                }
              }
            }
          }
          .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))

          HStack {
            Image(systemName: "magnifyingglass")
              .resizable()
              .frame(width: 22, height: 22)
              .foregroundColor(ColorsApp.white)
            TextField(
              "",
              text: $searchMovie,
              prompt: Text("Search your favorite coffee")
                .foregroundColor(ColorsApp.gray)
                .font(.custom(FontsApp.interThin, size: 17))
            )
            .foregroundColor(ColorsApp.white)
            .font(.custom(FontsApp.interLight, size: 17))
          }
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .background(ColorsApp.brown)
          .cornerRadius(18)
          .padding()

          switch storeCoffess.loading {
          case .sucess:
            LazyVGrid(columns: gridItemCoffee) {
              ForEach(storeCoffess.coffees) { coffee in
                // para NavigationLink funcionar precisa etar envolvido tudo no NaviagionView ou NavigationStack
                NavigationLink(destination: DetailsScreen(coffee: coffee, order: cart)) {
                  CoffeeItem(
                    coffee: coffee, order: cart,
                    handleSelectedCoffee: { handleSelectedCoffee(coffee) }
                  )
                }
              }
            }

          case .failure:
            TextError()

          default:
            PlaceholderListCoffe(cart: cart)
          }
        }
      }

      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
      .navigationBarBackButtonHidden(true)
      .onAppear {
        stateTabView.hiddeTabView = false
        storeAvatars.fetchAnAvatar(user.avatarId)
        storeCoffess.fetchAllCoffes()
      }
      // sheet
      // https://www.appcoda.com/swiftui-bottom-sheet-background/
      .sheet(isPresented: $isSheetPresented) {
        LazyVGrid(columns: gridItemAvatars, spacing: 15) {
          ForEach(avatarsMock) { avatars in
            RowAvatarImage(urlString: avatars.urlAvatar)
          }
          .presentationDetents([.medium])
          .presentationBackground(ColorsApp.brown)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(cart: CartObservable(), user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""))
      .environmentObject(StateNavigationTabView())
  }
}
