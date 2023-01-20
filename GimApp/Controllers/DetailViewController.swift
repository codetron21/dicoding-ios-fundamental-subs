//
//  DetailViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gameId:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
}

extension DetailViewController {
    
    func getDetailGame(id:Int) async {
        let service = NetworkService()
        do {
            try await service.getDetailGame(id)
        } catch {
            print("ERROR: \(error)")
        }
        
    }
}
