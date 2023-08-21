//
//  DetailsScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import SwiftUI
import URLImage

struct DetailsScreen: View {
  let coffee: CoffeesModel
  @Environment(\.dismiss) var dimiss
  @EnvironmentObject private var state: StateNavigationTabView
  @ObservedObject var order: CartObservable
  @State private var isAddedCart = false

  func handleBack() {
    dimiss()
  }

  func handleAddProduct() {
    let newOrder = OrdersModel(
      id: coffee.id,
      urlPhoto: coffee.urlPhoto,
      quantity: 1,
      price: coffee.price,
      name: coffee.name
    )
    order.cartOrder.append(newOrder)
    isAddedCart = true
  }

  var body: some View {
    ScrollView {
      VStack(spacing: 25) {
        URLImage(URL(string: coffee.urlPhoto)!) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
        }

        VStack(alignment: .leading, spacing: 5) {
          Text(coffee.name)
            .font(.custom(FontsApp.interMedium, size: 27))
            .foregroundColor(ColorsApp.white)

            .multilineTextAlignment(.leading)

          Text(coffee.description)
            .foregroundColor(ColorsApp.white)
            .modifier(FontWithLineHeight(font: UIFont(name: FontsApp.interLight, size: 20)!, lineHeight: 30))

            // se não conseguir mostrar o texto todo, ficar colocando 3 pontinhos no final sem que você queria
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      }

      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
    }
    // para adicionar no finalzinho o botão
    .safeAreaInset(edge: VerticalEdge.bottom) {
      HStack {
        VStack(alignment: .leading) {
          Text("Preço")
            .font(.custom(FontsApp.interLight, size: 17))
            .foregroundColor(ColorsApp.white)

          Text(coffee.price)
            .font(.custom(FontsApp.interBold, size: 20))
            .foregroundColor(ColorsApp.white)
        }

        CustomButtonDefault(
          handleButton: handleAddProduct,
          width: .infinity,
          title: isAddedCart ? "Adicionado" : "Adicionar",
          color: isAddedCart ? ColorsApp.brown : nil,
          textColor: isAddedCart ? ColorsApp.white : nil
        )
        .disabled(isAddedCart)
      }
      .padding(EdgeInsets(top: 20, leading: 20, bottom: 60, trailing: 20))
    }
    .onAppear {
      state.hiddeTabView = true
      isAddedCart = order.cartOrder.contains(where: { $0.id == coffee.id })
    }
    .onDisappear {
      state.hiddeTabView = false
    }
    .ignoresSafeArea(.all)
    .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
    .scrollBounceBehavior(.basedOnSize)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: handleBack) {
          Image(systemName: "chevron.left")
            .foregroundColor(
              ColorsApp.white
            )
        }
      }
    }
  }
}

struct DetailsScreen_Previews: PreviewProvider {
  static var previews: some View {
    DetailsScreen(coffee: coffeesMock[0], order: CartObservable())
  }
}
