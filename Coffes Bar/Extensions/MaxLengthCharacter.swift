//
//  MaxLengthCharacter.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 20/08/23.
//

import Foundation
import SwiftUI

// https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length
extension Binding where Value == String {
  func max(_ limit: Int) -> Self {
    if wrappedValue.count > limit {
      DispatchQueue.main.async {
        self.wrappedValue = String(self.wrappedValue.dropLast())
      }
    }
    return self
  }
}
