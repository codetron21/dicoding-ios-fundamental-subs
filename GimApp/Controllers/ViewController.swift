//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let headerView: MainHeaderUIView = {
        let header = MainHeaderUIView()
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "Black2Color")
    }
    
    private func addViews(){
        // measure size
        headerView.frame = CGRect(
            x:0,y:0,width: view.bounds.width,height: 100)
        
        // add actions
        headerView.setOnAboutClickListener { ()->() in
            self.navigateToAbout()
        }
        
        // add views
        view.addSubview(headerView)
    }
    
    private func navigateToAbout(){
        let viewController = UINavigationController(rootViewController:AboutViewController())
        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
}

