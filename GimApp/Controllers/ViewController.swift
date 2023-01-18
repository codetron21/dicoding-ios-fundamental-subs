//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "Black2Color")
        
        // set up navigation bar
        navigationItem.title = "Gim App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "RedColor") ?? UIColor.red]
        
        let itemAbout = UIBarButtonItem()
        itemAbout.image = UIImage(systemName: "person.circle")
        itemAbout.target = self
        itemAbout.action = #selector(actionAboutTap)
        
        navigationItem.rightBarButtonItem = itemAbout
    }
    
    private func addViews(){
        
    }
    
    private func navigateToAbout(){
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
}

extension ViewController {
    
    @objc func actionAboutTap(){
        print("debug: about")
        navigateToAbout()
    }
    
}

