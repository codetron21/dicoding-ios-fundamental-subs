//
//  FavoriteViewController.swift
//  GimApp
//
//  Created by Apple on 23/01/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "Black2Color")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private let loadingView: LoadingIndicatorView = {
        let loading = LoadingIndicatorView()
        loading.isHidden = true
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        applyConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")

        navigationItem.title = "Favorite Gim"

    }

    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let loadingConstraint = [
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(loadingConstraint)
    }
    
    private func addSubviews(){
        view.addSubview(tableView)
        view.addSubview(loadingView)
    }
    
}
