//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let indicatorView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.color = UIColor.white
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "Black2Color")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
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
        view.addSubview(indicatorView)
    }
    
    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let collectionConstraint = [
            tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ]
        
        let indicatorConstraint = [
            indicatorView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(indicatorConstraint)
        NSLayoutConstraint.activate(collectionConstraint)
    }
}

extension ViewController {
    
    func getGames() async {
        let service = NetworkService()
        do {
            games = try await service.getGames()
            tableView.reloadData()
        } catch {
            print("ERROR: \(error)")
        }
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(id: games[indexPath.count].id)
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
        cell.game = games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension ViewController {
    @objc func actionAboutTap(){
        print("DEBUG: about")
        navigateToAbout()
    }
}

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

