//
//  NetworkingHelper.swift
//  EZV_Assignment
//
//  Created by Ferry Julian on 17/03/23.
//

import Foundation

class NetworkingHelper {
    static let shared = NetworkingHelper()
    
    let baseURL = "https://dummyjson.com"
    
    func getData<T: Codable>(endpoint: String, type: T.Type, completion: @escaping(Result<T, Error>) -> ()) {
        guard let url = URL(string: "\(baseURL+endpoint)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
