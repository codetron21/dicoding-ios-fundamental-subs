//
//  GameModel.swift
//  GimApp
//
//  Created by Apple on 18/01/23.
//

import UIKit

// Domain
struct Game{
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let backgroundImage: URL
    
    var image:UIImage? = nil
    
    init(id:Int, name: String, rating: Float, released: String, backgroundImage: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.backgroundImage =  URL(string:backgroundImage)!
    }
}

struct GameDetail {
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let backgroundImage: URL
    let description: String
    
    var image:UIImage? = nil
    
    init(id:Int,name: String, rating: Float, released: String,backgroundImage:String,description:String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.backgroundImage = URL(string: backgroundImage)!
        self.description = description
    }
}


// Response
struct GameResponses: Codable {
    let results:[GameResponse]
    
    enum CodingKeys: String, CodingKey{
        case results
    }
}

struct GameResponse: Codable{
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let backgroundImage: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case rating
        case released
        case backgroundImage = "background_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Float.self, forKey: .rating)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        
        let dateString = try container.decode(String.self, forKey: .released)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let dateGet = dateFormatterGet.date(from: dateString)!
        let date = dateFormatter.string(from: dateGet)
        
        released = date
    }
}

struct GameDetailResponse: Codable{
    let id: Int
    let name: String
    let rating: Float
    let released: String
    let backgroundImage: String
    let description: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case rating
        case released
        case backgroundImage = "background_image"
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Float.self, forKey: .rating)
        description = try container.decode(String.self, forKey: .description)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        
        let dateString = try container.decode(String.self, forKey: .released)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let dateGet = dateFormatterGet.date(from: dateString)!
        let date = dateFormatter.string(from: dateGet)
        
        released = date
    }
    
}

class GameMapper {

    public static func map(
        input: [GameResponse]
    ) -> [Game]{
        return input.map{ result in
            return Game(
                id: result.id, name: result.name, rating: result.rating, released: result.released,
                backgroundImage: result.backgroundImage
            )
        }
    }
    
    public static func map(
        input: GameDetailResponse
    ) -> GameDetail{
        return GameDetail(
            id: input.id, name: input.name, rating: input.rating, released: input.released,backgroundImage: input.backgroundImage, description: input.description
        )
    }
    
}


