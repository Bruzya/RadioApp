//
//  NetworkService.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation


final class NetworkService {
    
    static let shared = NetworkService()
    
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    
    //MARK: - All Stations
    
    func fetchData(from url: String, _ completion: @escaping (Result<[Station], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                
                let station = try self.decoder.decode([Station].self, from: data)
                completion(.success(station))
                
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
