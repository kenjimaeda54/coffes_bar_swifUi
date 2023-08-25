//
//  AvatarWebService.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 23/08/23.
//

import Foundation

class AvatarWebService {
  func fetchAllAvatar(completion: @escaping (Result<[AvatarsModel], NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/avatars") else {
      return completion(.failure(.badUrl))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.invalidRequest))
      }

      do {
        let response = try JSONDecoder().decode([AvatarsModel].self, from: data)
        completion(.success(response))
      } catch {
        completion(.failure(.badDecoding))
      }
    }.resume()
  }

  func fetchAnAvatar(withId id: String, completion: @escaping (Result<AvatarsModel, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/avatars/\(id)") else {
      return completion(.failure(.badUrl))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let avatar = try JSONDecoder().decode(AvatarsModel.self, from: data)

        completion(.success(avatar))
      } catch {
        completion(.failure(.invalidRequest))
      }
    }.resume()
  }
}
