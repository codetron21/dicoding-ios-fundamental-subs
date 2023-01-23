//
//  GameModel.swift
//  GimApp
//
//  Created by Apple on 18/01/23.
//

import UIKit

// Domain
struct Game{
    let id:Int
    let name:String
    let rating:Float
    let released:String
    let bacgroundImage: URL
    
    var image:UIImage? = nil
    
    init(id:Int, name: String, rating: Float, released: String,bacgroundImage: String) {
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
    let rating:Float
    let released:String
    let bacgroundImage: URL
    let description: String
    
    var image:UIImage? = nil
    
    init(id:Int,name: String, rating: Float, released: String,backgroundImage:String,description:String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.bacgroundImage = URL(string: backgroundImage)!
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
    let id:Int
    let name:String
    let rating:Float
    let released:String
    let backgroundImage:String
    let description:String
    
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


