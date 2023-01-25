//
//  NetworkService.swift
//  GimApp
//
//  Created by Apple on 18/01/23.
//

import UIKit

class NetworkService {
    private let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        
        return value
    }()
    
    let baseUrl = "https://api.rawg.io/api/"
    
    static let shared = NetworkService()
    
    private init(){}
    
    func getGames() async throws -> [Game]{
        let path = "games"
        let pageSize = "20"
        
        var components = URLComponents(string: "\(baseUrl)\(path)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: pageSize)
        ]
        
        let result = try await requestHandler(url: components.url!, mapper: GameResponses.self)
        
        return GameMapper.map(input: result.results)
    }
    
    func getDetailGame(_ id:Int) async throws -> GameDetail{
        let path = "games/\(id)"
        
        var components = URLComponents(string: "\(baseUrl)\(path)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        let result = try await requestHandler(url: components.url!, mapper: GameDetailResponse.self)
        
        return GameMapper.map(input: result)
    }
    
    func dowloadImage(url: URL, completion: @escaping (UIImage?) -> Void)  {
        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            completion(UIImage(data:data))
        }
        
        downloadTask.resume()
    }
}

extension NetworkService {
    
    private func requestHandler<T>(url:URL, mapper: T.Type) async throws->T where T:Decodable {
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(mapper, from: data)
        
        return result
    }
    
}


