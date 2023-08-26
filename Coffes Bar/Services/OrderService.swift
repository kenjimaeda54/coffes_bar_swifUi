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

  func createOrderByCart(params: CartByUserModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/carts") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    do {
      // melhor maneira de gerar httpBody e usando o encode
      // pra isso precisa criar uma struct
      // https://www.appsdeveloperblog.com/http-post-request-example-in-swift/#google_vignette
      let jsonData = try JSONEncoder().encode(params)
      request.httpBody = jsonData

    } catch {
      print(error)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        if response?["status"] != "error" {
          completion(.success(true))
        }

      } catch {
        print(error)
        completion(.failure(.invalidRequest))
      }

    }.resume()
  }
}
