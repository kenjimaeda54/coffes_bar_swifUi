//
//  ArrayExtension.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 19/08/23.
//

import Foundation

// https://gist.github.com/cprovatas/d07226c3b8f4bd37dd6232d9ed013d6a
extension Array {
  static func ... (lhs: [Self.Element], rhs: [Self.Element]) -> [Self.Element] {
    var copy = lhs
    copy.append(contentsOf: rhs)
    return copy
  }

  static func ... (lhs: Self.Element, rhs: [Self.Element]) -> [Self.Element] {
    var copy = [lhs]
    copy.append(contentsOf: rhs)
    return copy
  }

  static func ... (lhs: [Self.Element], rhs: Self.Element) -> [Self.Element] {
    var copy = lhs
    copy.append(rhs)
    return copy
  }
}
