//
//  GameModel.swift
//  GimApp
//
//  Created by Apple on 18/01/23.
//

import Foundation
import UIKit

// Domain
struct Game{
    let id:Int
    let name:String
    let rating:Float
    let released:String
    let bacgroundImage: URL
    
    init(id:Int,name: String, rating: Float, released: String,bacgroundImage: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.bacgroundImage =  URL(string:bacgroundImage)!
    }
}

struct GameDetail {
    let id:Int
    let name:String
    let rating:Int
    let released:Date
    
    init(id:Int,name: String, rating: Int, released: Date) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
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
    let id:Int
    let name:String
    let rating:Float
    let released:String
    let backgroundImage:String
    
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        released = dateFormatter.string(from: date)
    }
}

struct GameDetailResponse: Codable{
    let id:Int
    let name:String
    let rating:Int
    let released:Date
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case rating
        case released
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Int.self, forKey: .rating)
        
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        released = dateFormatter.date(from: dateString)!
    }
    
}


