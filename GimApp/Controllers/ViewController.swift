//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    private  let service = NetworkService()
    
    private var games:[Game] = []
    
    private let cellId = "game-cell-id"
    
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
        
        // set up navigation bar
        navigationItem.title = "Gim App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "RedColor") ?? UIColor.red]
        
        let itemAbout = UIBarButtonItem()
        itemAbout.image = UIImage(systemName: "person.circle")
        itemAbout.target = self
        itemAbout.action = #selector(actionAboutTap)
        
        navigationItem.rightBarButtonItem = itemAbout
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(GameViewCell.self, forCellReuseIdentifier: cellId)
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(id: games[indexPath.row].id)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        as! GameViewCell
        let game =  games[indexPath.row]
        
        cell.game = game
        
        if cell.game?.image == nil {
            service.dowloadImage(url: game.bacgroundImage){image in
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

extension ViewController {
    
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
extension ViewController {
    @objc func actionAboutTap(){
        print("DEBUG: about")
        navigateToAbout()
    }
}

// Navigation
extension ViewController {
    private func navigateToAbout(){
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
    private func navigateToDetail(id:Int){
        let vc = DetailViewController()
        vc.gameId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}

