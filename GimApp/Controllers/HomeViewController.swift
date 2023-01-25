//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    
    private  let service = NetworkService.shared
    
    private var games:[Game] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupView()
        applyConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !games.isEmpty { return }
        Task { await getGames() }
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")
        
        let itemAbout = UIBarButtonItem()
        itemAbout.image = UIImage(systemName: "person.circle")
        itemAbout.target = self
        itemAbout.style = .plain
        itemAbout.action = #selector(actionAboutTap)
        
        let itemFavorite = UIBarButtonItem()
        itemFavorite.image = UIImage(systemName: "heart.circle")
        itemFavorite.target = self
        itemFavorite.style = .plain
        itemFavorite.action = #selector(actionFavoriteTap)
        
        navigationItem.title = "Gim App"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "RedColor") ?? UIColor.red,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)
        ]
        
        navigationItem.rightBarButtonItem = itemAbout
        navigationItem.leftBarButtonItem = itemFavorite
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameViewCell.self, forCellReuseIdentifier: GameViewCell.cellId)
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
    }
    
    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let collectionConstraint = [
            tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ]
        
        let loadingConstraint = [
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: safeGuide.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(loadingConstraint)
        NSLayoutConstraint.activate(collectionConstraint)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetail(id: games[indexPath.row].id)
    }
}

extension HomeViewController: UITableViewDataSource {
    
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
        
        if cell.game?.image == nil {
            service.dowloadImage(url: game.backgroundImage){image in
                DispatchQueue.main.async {
                    cell.game?.image = image
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension HomeViewController {
    
    private func getGames() async {
        loadingView.isHidden = false
        defer{ loadingView.isHidden = true }
        
        do {
            games = try await service.getGames()
            tableView.reloadData()
        } catch {
            print("ERROR: \(error)")
        }
    }
}

// Action listener
extension HomeViewController {
    
    @objc func actionFavoriteTap(){
        navigateToFavorite()
    }
    
    @objc func actionAboutTap(){
        navigateToAbout()
    }
}

// Navigation
extension HomeViewController {
    
    private func navigateToFavorite(){
        navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
    
    private func navigateToAbout(){
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
    private func navigateToDetail(id:Int){
        let vc = DetailViewController()
        vc.gameId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}

