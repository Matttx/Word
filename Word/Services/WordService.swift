//
//  WordServices.swift
//  Word
//
//  Created by Matteo on 10/11/2021.
//

import Alamofire
import Foundation

protocol WordServiceProtocol {
    func getWord(word: String, completion: @escaping (Result<[Details], WordError>) -> Void)
}

final class WordService: WordServiceProtocol {
    func getWord(word: String, completion: @escaping (Result<[Details], WordError>) -> Void) {
        AF.request(kAPIUrl + word, method: .get, headers: kAPIHeader)
            .validate()
            .responseJSON { response in
                switch response.result {
                    case .success(_):
                        if let data = response.data {
                            do {
                                let res = try JSONDecoder().decode(GetResponse.self, from: data)
                                let details = res.results
                                if res.results.isEmpty {
                                    completion(.failure(.wordNotFound))
                                }
                                completion(.success(details))
                            } catch {
                                completion(.failure(.unknown))
                            }
                        }
                    case .failure(_):
                        if response.response?.statusCode == 404 {
                            completion(.failure(.wordNotFound))
                        } else {
                            completion(.failure(.unknown))
                        }
                }
            }
    }
}
