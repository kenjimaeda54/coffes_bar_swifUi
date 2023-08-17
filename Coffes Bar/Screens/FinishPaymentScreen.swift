//
//  FinishedPaymentScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//

import PartialSheet
import SwiftUI

struct FinishPaymentScreen: View {
  @StateObject var locationManager = LocationManager()
  @Environment(\.dismiss) var dimiss
  @EnvironmentObject private var state: StateNavigation
  @State private var isSheetPresentedStreet = false
  @State private var isSheetPresentedDistrict = false
  @State private var isSheetPresentedStreetNumber = false
  @State private var isSheetPresentedCity = false
  @State private var streetNumber = ""
  @State private var district = ""
  @State private var city = ""

  func handleBack() {
    dimiss()
  }

  func returnTextIfValueFalse(conditional: Bool, value: String, optionalValue: String) -> String {
    return conditional ? optionalValue : value
  }

  var body: some View {
    VStack {
      InputAddress(
        isSheetPresented: $isSheetPresentedStreet,
        labelText: returnTextIfValueFalse(
          conditional: locationManager.addressUser.street.isEmpty,
          value: locationManager.addressUser.street,
          optionalValue: "Coloque o nome da rua"
        )
      )
      InputAddress(
        isSheetPresented: $isSheetPresentedStreetNumber,
        labelText: returnTextIfValueFalse(
          conditional: locationManager.addressUser.numberStreet.isEmpty,
          value: locationManager.addressUser.numberStreet,
          optionalValue: "Coloque numero da rua"
        )
      )
      InputAddress(
        isSheetPresented: $isSheetPresentedDistrict,
        labelText: returnTextIfValueFalse(
          conditional: locationManager.addressUser.district.isEmpty,
          value: locationManager.addressUser.district,
          optionalValue: "Coloque o nome do bairro"
        )
      )
      InputAddress(
        isSheetPresented: $isSheetPresentedCity,
        labelText: returnTextIfValueFalse(
          conditional: locationManager.addressUser.city.isEmpty,
          value: locationManager.addressUser.city,
          optionalValue: "Coloque o nome da cidade"
        )
      )
    }
    .onAppear {
      state.hiddeTabView = true
    }
    .onDisappear {
      state.hiddeTabView = false
    }
    .ignoresSafeArea(.all)
    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
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

struct FinishedPaymentScreen_Previews: PreviewProvider {
  static var previews: some View {
    FinishPaymentScreen()
      .environmentObject(StateNavigation())
  }
}
