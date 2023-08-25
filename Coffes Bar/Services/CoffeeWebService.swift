//
//  CoffeeWebService.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 22/08/23.
//

import Foundation

class CoffeeWebService {
  func fetchAllCoffes(completion: @escaping (Result<[CoffeesModel], NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/coffees") else {
      return completion(.failure(.badUrl))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode([CoffeesModel].self, from: data)
        completion(.success(response))

      } catch {
        completion(.failure(.badDecoding))
      }

    }.resume()
  }
}
