//
//  CartObservable.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 11/08/23.
//

import Foundation

class CartObservable: ObservableObject {
  @Published var cartOrder = [OrdersModel]()
}
