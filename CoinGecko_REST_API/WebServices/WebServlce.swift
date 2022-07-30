//
//  WebServlce.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 7/29/22.
//

import Foundation
import UIKit


class WebService {
    
    static let shared = WebService()
    private init() {}
    
    let baseURL = URL(string: "https://api.coingecko.com/api/v3/coins")
    
    func fetchAllCoins(completion: @escaping (Result<[Coin], NetworkError>) ->()) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                let sortedCoinsArray = coins.sorted { $0.name < $1.name }
                
                return completion(.success(sortedCoinsArray))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func fetchImage(for coin: Coin, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let imageURl = URL(string: coin.image.small) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: imageURl) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
        }.resume()
    }
    
    func fetchLargeImage(for coin: Coin, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let imageURl = URL(string: coin.image.large) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: imageURl) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
        }.resume()
    }
}
