//
//  formatStringForDouble.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 25/08/23.
//

import Foundation

func conveterStringCurrencyInDouble(_ value: String) -> Double {
  // replace string https://www.tutorialspoint.com/swift-program-to-replace-a-character-at-a-specific-index#:~:text=Method%203%3A%20Using%20the%20replacingCharacters,by%20the%20given%20replacement%20character.
  // number foramt currency
  // https://medium.com/@mariannM/currency-converter-in-swift-4-2-97384a56da41
  let stringSplitComma = value.split(separator: ",")
  let stringSplitSymbol = stringSplitComma[0].split(separator: " ")
  let stringSlpited = "\(stringSplitSymbol[1]).\(stringSplitComma[1])"
  return Double(stringSlpited) ?? 0.0
}
