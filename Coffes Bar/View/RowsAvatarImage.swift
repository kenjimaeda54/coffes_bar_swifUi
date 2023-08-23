//
//  RowsCoffeeBar.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 19/08/23.
//

import SwiftUI

struct RowAvatarImage: View {
  let urlString: String
  var body: some View {
    AsyncImage(url: URL(string: urlString), scale: 5) { phase in
      if let image = phase.image {
        image
          .resizable()
          .frame(width: 80, height: 80)
          .clipShape(Circle())
          .aspectRatio(contentMode: .fit)

      } else if phase.error != nil {
        Text("Erro ao carregar as imagens")
      } else {
        Image("profile-default")
          .resizable()
          .frame(width: 80, height: 80)
          .aspectRatio(contentMode: .fit)
          .clipShape(Circle())
          .redactShimmer(condition: true)
          .foregroundColor(ColorsApp.gray)
      }
    }
  }
}

struct RowsAvatarImage_Previews: PreviewProvider {
  static var previews: some View {
    RowAvatarImage(urlString: "https://github.com/kenjimaeda.png")
  }
}
