//
//  UserWebService.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

class UserWebService {
  func createUser(params: [String: Any], completion: @escaping (Result<UsersModel, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/users/sigin") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    request.httpMethod = "POST"

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
          response.forEach {
            let dictionary = $0 as? [String: String]

            let user = UsersModel(
              id: dictionary?["_id"] ?? "",
              name: dictionary?["name"] ?? "",
              email: dictionary?["email"] ?? "",
              avatarId: dictionary?["avatarId"] ?? "",
              password: dictionary?["password"] ?? ""
            )
            completion(.success(user))
          }
        } else {
          completion(.failure(.noData))
        }

      } catch {
        print(error.localizedDescription)
        completion(.failure(.noData))
      }

    }.resume()
  }

  func loginUser(params: [String: Any], completion: @escaping (Result<UsersModel, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/users/login") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    // se precisar de token
    // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //	request.setValue(Constants.API_TOKEN, forHTTPHeaderField: "Authorization")

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.badUrl))
      }

      do {
        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
          if response["error"] != nil {
            completion(.failure(.noData))
          } else {
            let user = UsersModel(
              id: response["_id"] ?? "",
              name: response["name"] ?? "",
              email: response["email"] ?? "",
              avatarId: response["avatarId"] ?? "",
              password: response["password"] ?? ""
            )

            completion(.success(user))
          }
        }

      } catch {
        completion(.failure(.noData))
      }

    }.resume()
  }

  func updateAvatar(
    withUpateAvatar updateAvar: UpdateAvatarModel,
    andUserId userId: String,
    completion: @escaping (Result<Bool, NetworkError>) -> Void
  ) {
    guard let url = URL(string: "\(baseUrl)/users/avatar?userId=\(userId)") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    do {
      let jsonEncode = try JSONEncoder().encode(updateAvar)
      request.httpBody = jsonEncode
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        if response?["sucess"] != nil {
          completion(.success(true))
        }

      } catch {
        print(error.localizedDescription)
        completion(.failure(.invalidRequest))
      }
    }.resume()
  }
}
