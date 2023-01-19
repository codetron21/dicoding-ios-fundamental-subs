//
//  NetworkService.swift
//  GimApp
//
//  Created by Apple on 18/01/23.
//

import Foundation



class NetworkService {
    let apiKey = "f23d88453d554389a4f5acf9f3a55b77"
    let baseUrl = "https://api.rawg.io/api/"
    
    func getGames() async throws -> [Game]{
        let path = "games"
        let pageSize = "20"
        
        var components = URLComponents(string: "\(baseUrl)\(path)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: pageSize)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameResponses.self, from: data)
        
        return gameMapper(input: result.results)
    }
    
    func getDetailGame(_ id:Int){
        
    }
}

extension NetworkService {
    fileprivate func gameMapper(
        input: [GameResponse]
    ) -> [Game]{
        return input.map{ result in
            return Game(
                id: result.id, name: result.name, rating: result.rating, released: result.released
            )
        }
    }
}
