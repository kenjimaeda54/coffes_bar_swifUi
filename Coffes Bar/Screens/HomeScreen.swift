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
  @State private var listIdSelected: [String] = []

  func handleSelectedCoffee(_ itemSelected: CoffeesModel) {
    if let index = listIdSelected.firstIndex(where: { $0 == itemSelected.id }) {
      listIdSelected.remove(at: index)
      let indexOrder = cart.cartOrder.firstIndex(where: { $0.id == itemSelected.id })
      cart.cartOrder.remove(at: indexOrder!)

    } else {
      listIdSelected.append(itemSelected.id)
      let cartOrder = CartOderModel(
        id: itemSelected.id,
        urlPhoto: itemSelected.urlPhoto,
        quantity: 1,
        price: itemSelected.price,
        name: itemSelected.name
      )

      cart.cartOrder.append(cartOrder)
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
            AsyncImage(
              url: URL(
                string: "https://firebasestorage.googleapis.com/v0/b/uploadimagesapicoffee.appspot.com/o/avatar01.png?alt=media&token=4a3820fa-b757-4bcd-b148-1cd914956112"
              ),
              scale: 7
            )
            .aspectRatio(contentMode: .fit)
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

          LazyVGrid(columns: gridItem) {
            ForEach(coffeesMock) { coffee in
              // para NavigationLink funcionar precisa etar envolvido tudo no NaviagionView
              NavigationLink(destination: DetailsScreen(coffee: coffee, order: cart)) {
                CoffeeItem(
                  coffee: coffee,
                  listIdSelected: $listIdSelected,
                  handleSelectedCoffee: { handleSelectedCoffee(coffee) }
                )
              }
            }
          }
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(cart: CartObservable())
  }
}
