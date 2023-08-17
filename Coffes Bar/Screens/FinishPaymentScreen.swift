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
  @State private var isSheetPresented = false

  func handleBack() {
    dimiss()
  }

  func handleAction() {
    isSheetPresented = true
  }

  var body: some View {
    VStack {
      InputAddress {
        Button(action: handleAction) {
          Text("Insira o endereço")
            .font(.custom(FontsApp.interLight, size: 17))
            .foregroundColor(ColorsApp.gray)
        }
      }
      .sheet(isPresented: $isSheetPresented) {
        SheetTextFieldView()
          .presentationDetents([.fraction(0.15)])
          .presentationDragIndicator(.hidden)
      }
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
