//
//  PurchaseMadeScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 17/08/23.
//

import SwiftUI

struct PurchaseMadeScreen: View {
  @ObservedObject var cart: CartObservable
  @EnvironmentObject private var stateTabView: StateNavigationTabView
  @EnvironmentObject private var stateStackView: StateNavigationStack
  @State private var goWhenTrue = false
  @Environment(\.dismiss) var dismiss

  let city: String
  let district: String
  let street: String
  let streetNumber: String
  let valueTotal: Double

  func handleBack() {
    stateStackView.isActiveFinishPayment = false
    stateStackView.isActivePurchasePayment = false
    stateTabView.tagSelected = 0
    cart.cartOrder = []
    dismiss()
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        Text(
          "Obrigado por comprar em nossas lojas, o pagamento sera feito na entrega, vendedor precisa disponilizar possiblidade pagamento por cartão de credito,debito ou pix.\nFique a vontade para entrar contato com nossos canais de comunicação para qualquer duvida."
        )
        .modifier(FontWithLineHeight(
          font: UIFont(name: FontsApp.interRegular, size: 17)!,
          lineHeight: 28
        ))
        .foregroundColor(ColorsApp.beige)
      }
      .onAppear {
        stateTabView.hiddeTabView = true
        goWhenTrue = false
      }
      .safeAreaInset(
        edge: .bottom,
        content: {
          CustomButtonDefault(
            handleButton: { handleBack() },
            width: .infinity,
            title: "Voltar usar app",
            color: nil,
            textColor: nil
          )
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
      )
      .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
      .scrollBounceBehavior(.basedOnSize)
      .navigationBarBackButtonHidden(true)
    }
  }
}

struct PurchaseMadeScreen_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseMadeScreen(
      cart: CartObservable(),
      city: "Ru Geraneos",
      district: "Yara",
      street: "35",
      streetNumber: "Pouso Alegre",
      valueTotal: 35.00
    )
    .environmentObject(StateNavigationTabView())
    .environmentObject(StateNavigationStack())
  }
}
