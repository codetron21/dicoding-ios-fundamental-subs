//
//  GameProvider.swift
//  GimApp
//
//  Created by Apple on 24/01/23.
//

import Foundation
import CoreData

class GameProvider {
    
    static let shared = GameProvider()
    
    private init(){  }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameData")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAllGame(completion: @escaping(_ games: [Game]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Game] = []
                
                if results.isEmpty {
                    return completion(games)
                }
                
                for result in results {
                    let game = Game(
                        id: Int(result.value(forKeyPath: "id") as! Int32),
                        name: result.value(forKey: "name") as! String,
                        rating: result.value(forKey: "rating") as! Float,
                        released: result.value(forKey: "released") as! String,
                        backgroundImage: result.value(forKey: "background_image") as! String
                    )
                    
                    games.append(game)
                }
                
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func isGameFavorited(id:Int, completion: @escaping(Bool)->Void){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let result = try taskContext.fetch(fetchRequest).first
                completion(result != nil)
            } catch let error as NSError {
                completion(false)
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveGame(
        id: Int,
        name: String,
        released: String,
        rating: Float,
        backgroundImage: URL,
        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "GameEntity", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKeyPath: "id")
                game.setValue(name, forKeyPath: "name")
                game.setValue(released, forKeyPath: "released")
                game.setValue(rating, forKeyPath: "rating")
                game.setValue(backgroundImage.absoluteString, forKey: "background_image")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteGame(id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
}

