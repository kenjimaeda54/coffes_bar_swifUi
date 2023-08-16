//
//  FinishedPaymentScreen.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//

import SwiftUI

struct FinishPaymentScreen: View {
  @StateObject var locationManager = LocationManager()
  @Environment(\.dismiss) var dimiss
  @EnvironmentObject private var state: StateNavigation

  func handleBack() {
    dimiss()
  }

  var body: some View {
    VStack {
      Text(locationManager.addressUser.city)
      Text(locationManager.addressUser.street)
      Button {
        locationManager.requestLocationPermission()
      } label: {
        Text("Pegar")
      }
    }
    .onAppear {
      state.hiddeTabView = true
    }
    .onDisappear {
      state.hiddeTabView = false
    }
    .ignoresSafeArea(.all)
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
    FinishPaymentScreen().environmentObject(StateNavigation())
  }
}
