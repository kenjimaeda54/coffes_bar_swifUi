//
//  ContentView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 09/08/23.
//

import SwiftUI
import SwiftUISnackbar

struct HomeScreen: View {
  @State private var searchCoffee = ""
  @ObservedObject var cart: CartObservable
  @EnvironmentObject private var stateTabView: StateNavigationTabView
  @State private var isSheetPresented = false
  @StateObject var storeCoffess = StoreCoffess()
  @StateObject var storeAvatars = StoreAvatar()
  @StateObject var storeUpdateUser = StoreUsers()
  @State private var collectionCoffee: [CoffeesModel] = []
  @State private var urlAvatarSelected = ""
  @State private var isSnackBarPresented = false
  @FocusState private var searchIsFocused: Bool
  var user: UsersModel
  @Binding var isLoggedIn: Bool

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

  func handleInputCoffeFavorite(_ newValue: String) {
    if searchCoffee.count % 3 == 0 {
      do {
        let regex = try NSRegularExpression(pattern: newValue, options: .caseInsensitive)
        collectionCoffee = storeCoffess.coffees.filter { regex.matches($0.name) }

      } catch {
        print(error)
        collectionCoffee = []
      }
    }

    if searchCoffee.count < 2 {
      collectionCoffee = []
    }
  }

  func handleUpateAvatar(_ avatar: AvatarsModel) {
    let updateAvatar = UpdateAvatarModel(avatarId: avatar.id)

    storeUpdateUser.updateUserAvatar(withUpdateAvatar: updateAvatar, andUserId: user.id) { stats in

      switch stats {
      case true:
        urlAvatarSelected = avatar.urlAvatar
        isSheetPresented = false

      case false:

        isSnackBarPresented = true
      }
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
              HStack(alignment: .bottom) {
                AsyncImage(url: URL(
                  string: urlAvatarSelected.isEmpty ? storeAvatars.avatarByUser.urlAvatar : urlAvatarSelected
                ), scale: 7) { phase in

                  if phase.error != nil {
                    Text("Não consegui carregar foto")
                      .font(.custom(FontsApp.interLight, size: 11))
                  }

                  if let image = phase.image {
                    image
                      .resizable()
                      .frame(width: 80, height: 80)
                      .aspectRatio(contentMode: .fit)

                  } else {
                    PlaceholderAvatar()
                  }
                }

                Button(action: { isLoggedIn = false }) {
                  Image(systemName: "power.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(ColorsApp.red)
                    .offset(y: -10)
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
              text: Binding(
                get: {
                  searchCoffee
                }, set: { newValue, _ in
                  if let _ = newValue.lastIndex(of: "\n") {
                    searchIsFocused = false
                  } else {
                    searchCoffee = newValue
                  }
                }

              ).max(50),
              prompt: Text("Search your favorite coffee")
                .foregroundColor(ColorsApp.gray)
                .font(.custom(FontsApp.interThin, size: 17)),
              axis: .vertical
            )
            .focused($searchIsFocused)
            .foregroundColor(ColorsApp.white)
            .font(.custom(FontsApp.interLight, size: 17))
            .onChange(of: searchCoffee, perform: handleInputCoffeFavorite)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
          }
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .background(ColorsApp.brown)
          .cornerRadius(18)
          .padding()

          if collectionCoffee.isEmpty {
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

          } else {
            LazyVGrid(columns: gridItemCoffee) {
              ForEach(collectionCoffee) { coffee in
                // para NavigationLink funcionar precisa etar envolvido tudo no NaviagionView ou NavigationStack
                NavigationLink(destination: DetailsScreen(coffee: coffee, order: cart)) {
                  CoffeeItem(
                    coffee: coffee, order: cart,
                    handleSelectedCoffee: { handleSelectedCoffee(coffee) }
                  )
                }
              }
            }
          }
        }
      }

      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
      .navigationBarBackButtonHidden(true)
      .onAppear {
        stateTabView.hiddeTabView = false
        storeAvatars.fetchAnAvatar(user.avatarId)
        storeAvatars.fetchAllAvatar()
        storeCoffess.fetchAllCoffes()
        collectionCoffee = storeCoffess.coffees
      }
      // sheet
      // https://www.appcoda.com/swiftui-bottom-sheet-background/
      .sheet(isPresented: $isSheetPresented) {
        LazyVGrid(columns: gridItemAvatars, spacing: 15) {
          ForEach(storeAvatars.avatar) { avatars in
            Button(action: { handleUpateAvatar(avatars) }) {
              RowAvatarImage(urlString: avatars.urlAvatar)
            }
          }
          .presentationDetents([.medium])
          .presentationBackground(ColorsApp.brown)
        }
      }
      .snackbar(
        isShowing: $isSnackBarPresented,
        title: "Não foi possível atualizar avatar",
        style: .custom(ColorsApp.brown)
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(
      cart: CartObservable(),
      user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""),
      isLoggedIn: .constant(false)
    )

    .environmentObject(StateNavigationTabView())
  }
}
