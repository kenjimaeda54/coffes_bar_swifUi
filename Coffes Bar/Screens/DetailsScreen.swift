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

  func handleBack() {
    dimiss()
  }

  var body: some View {
    ScrollView {
      VStack(spacing: 25) {
        URLImage(URL(string: coffee.urlPhoto)!) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .modifier(CornerRadiusStyle(radius: 90, corners: [.bottomLeft, .bottomRight])).frame(
              width: .infinity,
              height: 320
            )
        }

        VStack(alignment: .leading, spacing: 5) {
          Text(coffee.name)
            .font(.custom(FontsApp.interMedium, size: 27))
            .foregroundColor(ColorsApp.white)

            .multilineTextAlignment(.leading)

          Text(coffee.description)
            .foregroundColor(ColorsApp.white)
            .modifier(FontWithLineHeight(font: UIFont(name: FontsApp.interLight, size: 20)!, lineHeight: 30))

          Spacer(minLength: 35)
          HStack {
            VStack(alignment: .leading) {
              Text("Preço")
                .font(.custom(FontsApp.interLight, size: 17))
                .foregroundColor(ColorsApp.white)

              Text(coffee.price)
                .font(.custom(FontsApp.interBold, size: 20))
                .foregroundColor(ColorsApp.white)
            }

            CustomButtonPay(handleButton: {}, width: .infinity, title: "Comprar agora")
          }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
    }
    .ignoresSafeArea(.all)
    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
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
    DetailsScreen(coffee: coffeesMock[0])
  }
}
