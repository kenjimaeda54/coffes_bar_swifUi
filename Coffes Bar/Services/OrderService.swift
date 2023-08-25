//
//  OrdersServices.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 24/08/23.
//

import Foundation

class OrderService {
  func fetchAnOrder(withIdUser id: String, completion: @escaping (Result<[OrdersByUserModel], NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/carts/orders?userId=\(id)") else {
      return completion(.failure(.badUrl))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONDecoder().decode([OrdersByUserModel].self, from: data)
        completion(.success(response))
      } catch {
        print(error)
        completion(.failure(.invalidRequest))
      }

    }.resume()
  }
}
