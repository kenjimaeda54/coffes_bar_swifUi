//
//  StoreLocation.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 16/08/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()

  @Published var location: CLLocationCoordinate2D?
  private let locationManager = CLLocationManager()
  @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
  @Published var addressUser = UserAddressModel(city: "", street: "", numberStreet: "", district: "")

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }

  func requestLocationPermission() {
    locationManager.requestWhenInUseAuthorization()
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authorizationStatus = manager.authorizationStatus
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = CLLocation(
      latitude: locations.first?.coordinate.latitude ?? 00.00,
      longitude: locations.first?.coordinate.longitude ?? 00.00
    )
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
      guard error == nil else {
        print("Reverse geocoder failed with error")
        return
      }
      guard !placemarks!.isEmpty else {
        print("Problem with the data received from geocoder")
        return
      }
      let placeMark = placemarks![0]

      self.addressUser = UserAddressModel(
        city: placeMark.locality ?? " ",
        street: placeMark.thoroughfare ?? " ",
        numberStreet: placeMark.subThoroughfare ?? " ",
        district: placeMark.subLocality ?? " "
      )

      // placeMark.country ==> pais
      // placeMark.locality ==> cidade
      // placeMark.subLocality ==> bairro
      // placeMark.thoroughfare ==> rua
      // placeMark.postalCode ==> postal code
      // placeMark.subThoroughfare ==> numero da rua

    })
  }
}
