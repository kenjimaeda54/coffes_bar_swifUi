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
  @StateObject var storeCart = StoreOrders()
  @ObservedObject var cart: CartObservable
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject private var stateTabView: StateNavigationTabView
  @EnvironmentObject private var stateStack: StateNavigationStack
  @State private var isSheetPresentedStreet = false
  @State private var isSheetPresentedDistrict = false
  @State private var isSheetPresentedStreetNumber = false
  @State private var isSheetPresentedCity = false
  @State private var streetNumber = ""
  @State private var street = ""
  @State private var district = ""
  @State private var city = ""
  @State var goWhenTrue = false
  let tax: Double
  let valueTotalCart: Double
  let userId: String

  func handleBack() {
    dismiss()
  }

  func returnTextIfValueFalse(conditional: Bool, value: String, optionalValue: String) -> String {
    return conditional ? optionalValue : value
  }

  // exemplos de http body
  // https://www.appsdeveloperblog.com/http-post-request-example-in-swift/
  func handleCreateCars() {
    let orderByUser = cart.cartOrder.map { OrdersByUser(
      title: $0.name,
      urlImage: $0.urlPhoto,
      price: $0.price,
      quantity: $0.quantity
    ) }

    let formatValueTotal = String(format: "%.2f", valueTotalCart).replacingOccurrences(of: ".", with: ",")

    let formatTax = String(format: "%.2f", tax).replacingOccurrences(of: ".", with: ",")

    let demand = DemandByUserModel(
      orders: orderByUser,
      priceCartTotal: "R$ \(formatValueTotal)",
      userId: userId,
      tax: "R$ \(formatTax)"
    )
    let params = CartByUserModel(cart: demand)

    storeCart.createOrdersCart(params)
    stateStack.isActivePurchasePayment = true
  }

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 10) {
        HStack {
          ButtonTextFieldWithSheet(
            isSheetPresented: $isSheetPresentedStreet,
            textField: street,
            labelText: returnTextIfValueFalse(
              conditional: locationManager.addressUser.street.isEmpty,
              value: locationManager.addressUser.street,
              optionalValue: "Nome da rua"
            )
          ) {
            TextFieldSheetDefault(placeHolderTextField: returnTextIfValueFalse(
              conditional: locationManager.addressUser.street.isEmpty,
              value: locationManager.addressUser.street,
              optionalValue: "Nome da rua"
            ), valueTextField: $street, isSheetPresented: $isSheetPresentedStreet)
          }
          ButtonTextFieldWithSheet(
            isSheetPresented: $isSheetPresentedStreetNumber,
            textField: streetNumber, labelText: returnTextIfValueFalse(
              conditional: locationManager.addressUser.numberStreet.isEmpty,
              value: locationManager.addressUser.numberStreet,
              optionalValue: "Numero da rua"
            )
          ) {
            TextFieldSheetDefault(
              placeHolderTextField: returnTextIfValueFalse(
                conditional: locationManager.addressUser.numberStreet.isEmpty,
                value: locationManager.addressUser.numberStreet,
                optionalValue: "Numero da rua"
              ),
              valueTextField: $streetNumber,
              isSheetPresented: $isSheetPresentedStreetNumber
            )
          }
        }

        ButtonTextFieldWithSheet(
          isSheetPresented: $isSheetPresentedDistrict,
          textField: district, labelText: returnTextIfValueFalse(
            conditional: locationManager.addressUser.district.isEmpty,
            value: locationManager.addressUser.district,
            optionalValue: "Coloque o nome do bairro"
          )
        ) {
          TextFieldSheetDefault(
            placeHolderTextField: returnTextIfValueFalse(
              conditional: locationManager.addressUser.district.isEmpty,
              value: locationManager.addressUser.district,
              optionalValue: "Coloque o nome do bairro"
            ),
            valueTextField: $district,
            isSheetPresented: $isSheetPresentedDistrict
          )
        }
        ButtonTextFieldWithSheet(
          isSheetPresented: $isSheetPresentedCity,
          textField: city, labelText: returnTextIfValueFalse(
            conditional: locationManager.addressUser.city.isEmpty,
            value: locationManager.addressUser.city,
            optionalValue: "Coloque o nome da cidade"
          )
        ) {
          TextFieldSheetDefault(placeHolderTextField: returnTextIfValueFalse(
            conditional: locationManager.addressUser.city.isEmpty,
            value: locationManager.addressUser.city,
            optionalValue: "Coloque o nome da cidade"
          ), valueTextField: $city, isSheetPresented: $isSheetPresentedCity)
        }
        Button {
          locationManager.requestLocationPermission()
        } label: {
          Image(systemName: "location.square.fill")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(ColorsApp.beige)
        }
      }
      .onAppear {
        stateTabView.hiddeTabView = true
      }
      .navigationBarBackButtonHidden(true)
      .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(ColorsApp.black, ignoresSafeAreaEdges: .all)
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
      .safeAreaInset(edge: .bottom) {
        VStack(spacing: 15) {
          OverviewPayment(tax: tax, value: valueTotalCart)
          CustomButtonDefault(
            handleButton: handleCreateCars,
            width: .infinity,
            title: "Tudo certo",
            color: nil,
            textColor: nil
          )
          .navigationDestination(isPresented: $stateStack.isActivePurchasePayment) {
            PurchaseMadeScreen(
              cart: cart,
              city: returnTextIfValueFalse(
                conditional: city.isEmpty,
                value: city,
                optionalValue: locationManager.addressUser.city
              ),
              district: returnTextIfValueFalse(
                conditional: district.isEmpty,
                value: district,
                optionalValue: locationManager.addressUser.district
              ),
              street: returnTextIfValueFalse(
                conditional: street.isEmpty,
                value: street,
                optionalValue: locationManager.addressUser.street
              ),
              streetNumber: returnTextIfValueFalse(
                conditional: streetNumber.isEmpty,
                value: streetNumber,
                optionalValue: locationManager.addressUser.numberStreet
              ),
              valueTotal: tax + valueTotalCart
            )
          }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
      }
    }
  }
}

struct FinishedPaymentScreen_Previews: PreviewProvider {
  static var previews: some View {
    FinishPaymentScreen(cart: CartObservable(), tax: 3.20, valueTotalCart: 12.0, userId: "")
      .environmentObject(StateNavigationTabView())
      .environmentObject(StateNavigationStack())
  }
}
