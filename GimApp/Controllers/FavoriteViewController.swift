//
//  FavoriteViewController.swift
//  GimApp
//
//  Created by Apple on 23/01/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private var games:[Game] = []
    
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
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.text = "No favorite Gim"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameViewCell.self, forCellReuseIdentifier: GameViewCell.cellId)
    }

    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let loadingConstraint = [
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor)
        ]
        
        let emptyConstraint = [
            emptyLabel.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(loadingConstraint)
        NSLayoutConstraint.activate(emptyConstraint)
    }
    
    private func addSubviews(){
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(emptyLabel)
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetail(id: games[indexPath.row].id)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameViewCell.cellId, for: indexPath)
        as! GameViewCell
        let game =  games[indexPath.row]
        
        cell.game = game
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// Navigation
extension FavoriteViewController {
    
    private func navigateToDetail(id:Int){
        let vc = DetailViewController()
        vc.gameId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
