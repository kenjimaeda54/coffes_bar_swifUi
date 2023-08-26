//
//  OverviewPayment.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 17/08/23.
//

import SwiftUI

struct OverviewPayment: View {
  let tax: Double
  let value: Double

  var formatValueTotal: String {
    return String(format: "%.2f", value + tax).replacingOccurrences(of: ".", with: ",")
  }

  var formatValue: String {
    return String(format: "%.2f", value).replacingOccurrences(of: ".", with: ",")
  }

  var formatTax: String {
    return String(format: "%.2f", tax).replacingOccurrences(of: ".", with: ",")
  }

  var body: some View {
    HStack {
      Text("Taxa de entrega")
        .font(.custom(FontsApp.interRegular, size: 17))
        .foregroundColor(ColorsApp.white)
      Spacer()
      Text("R$ \(formatTax)")
        .font(.custom(FontsApp.interBold, size: 19))
        .foregroundColor(ColorsApp.white)
    }
    HStack {
      Text("Valor")
        .font(.custom(FontsApp.interRegular, size: 17))
        .foregroundColor(ColorsApp.white)
      Spacer()
      Text("R$ \(formatValue)")
        .font(.custom(FontsApp.interBold, size: 19))
        .foregroundColor(ColorsApp.white)
    }
    Divider()
      .frame(minHeight: 1)
      .overlay(ColorsApp.white.opacity(0.2))
    HStack {
      Text("Total")
        .font(.custom(FontsApp.interRegular, size: 17))
        .foregroundColor(ColorsApp.white)
      Spacer()
      Text("R$ \(formatValueTotal)")
        .font(.custom(FontsApp.interBold, size: 19))
        .foregroundColor(ColorsApp.white)
    }
  }
}

struct OverviewPayment_Previews: PreviewProvider {
  static var previews: some View {
    OverviewPayment(tax: 5.3, value: 22.5)
  }
}
