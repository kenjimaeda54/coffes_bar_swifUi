//
//  StateNavigation.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 14/08/23.
//

import Foundation

class StateNavigationTabView: ObservableObject {
  @Published var hiddeTabView: Bool = false
  @Published var tagSelected = 0
}
