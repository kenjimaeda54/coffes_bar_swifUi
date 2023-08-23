//
//  Constants.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 10/08/23.
//

import Foundation
import SwiftUI

// MARK: - Layout

let columnSpacing: CGFloat = 10
var gridItemCoffee: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: columnSpacing), count: 2)
}

var gridItemAvatars: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: columnSpacing), count: 3)
}

// MARK: - URL

let baseUrl = "http://localhost:3000"
