//
//  DetailViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gameId: Int? = nil
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor(named: "RedColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "WhiteColor")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "WhiteColor")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupView()
        applyConstraint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id = gameId else {return}
        Task { await getDetailGame(id) }
    }
    
    private func addViews(){
        stackView.addArrangedSubview(posterImage)
        stackView.addArrangedSubview(releasedLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")
        
        // set up navigation bar
        navigationItem.title = "Detail Gim"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "RedColor") ?? UIColor.red]
        
    }
    
    private func applyConstraint() {
        
        let scrollConstraint = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let stackConstraint = [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        let posterConstraint = [
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: releasedLabel.topAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollConstraint)
        NSLayoutConstraint.activate(stackConstraint)
        NSLayoutConstraint.activate(posterConstraint)
    }
    
    private func configureView(game:GameDetail){
        posterImage.load(url: game.bacgroundImage)
        releasedLabel.text = game.released
        titleLabel.text = game.name
        ratingLabel.text  = String(game.rating)
        descriptionLabel.text = game.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

extension DetailViewController {
    
    private func getDetailGame(_ id:Int) async {
        let service = NetworkService()
        do {
            let result = try await service.getDetailGame(id)
            configureView(game: result)
        } catch {
            print("ERROR: \(error)")
        }
    }
    
}
