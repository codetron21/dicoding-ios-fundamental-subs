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
    
    private let notchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BlackColor")
        return view
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
            x:0,y:50,width: view.bounds.width,height: 50)
        
        notchView.frame = CGRect(
            x:0,y:0,width: view.bounds.width,height: 50)
        
        // add views
        view.addSubview(headerView)
        view.addSubview(notchView)
    }
    
}

