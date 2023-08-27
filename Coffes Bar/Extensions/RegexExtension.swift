//
//  RegexExtension.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 27/08/23.
//

import Foundation

extension NSRegularExpression {
  func matches(_ string: String) -> Bool {
    let range = NSRange(location: 0, length: string.utf16.count)
    return firstMatch(in: string, options: [], range: range) != nil
  }
}
