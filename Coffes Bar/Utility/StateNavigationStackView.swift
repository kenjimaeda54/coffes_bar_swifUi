//
//  StateNavigationStackView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import Foundation
import SwiftUI

class StateNavigationStackView: ObservableObject {
  @Published var isActiveFinishPayment = false
  @Published var isActivePurchasePayment = false
}
