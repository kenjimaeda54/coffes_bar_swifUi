//
//  StateNavigationStackView.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import Foundation
import SwiftUI

// https://www.youtube.com/watch?v=6sySblPWwBc
class StateNavigationStack: ObservableObject {
  @Published var isActiveFinishPayment = false
  @Published var isActivePurchasePayment = false
  @Published var isLogin = false
  @Published var isSigin = false
}
