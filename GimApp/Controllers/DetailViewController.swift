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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor(named: "RedColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "WhiteColor")
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "WhiteColor")
        label.textAlignment = .right
        label.numberOfLines = 1
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
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingView: LoadingIndicatorView = {
        let loading = LoadingIndicatorView()
        loading.isHidden = true
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
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
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(releasedLabel)
        contentView.addSubview(descriptionLabel)
        
        scrollView.addSubview(contentView)
        
        view.addSubview(scrollView)
        view.addSubview(loadingView)
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")

        navigationItem.title = "Detail Gim"
    }
    
    private func applyConstraint() {
        let safeGuide = view.safeAreaLayoutGuide
        
        let scrollConstraint = [
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ]
        
        let contentConstraint = [
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        let posterConstraint = [
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        ]
        
        let releasedConstraint = [
            releasedLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant:  10),
            releasedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
        ]
        
        let titleConstraint = [
            titleLabel.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
        ]
        
        let ratingConstraint = [
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        
        let descriptionConstraint = [
            descriptionLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor,constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let loadingConstraint = [
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(contentConstraint)
        NSLayoutConstraint.activate(loadingConstraint)
        NSLayoutConstraint.activate(scrollConstraint)
        NSLayoutConstraint.activate(posterConstraint)
        NSLayoutConstraint.activate(releasedConstraint)
        NSLayoutConstraint.activate(titleConstraint)
        NSLayoutConstraint.activate(ratingConstraint)
        NSLayoutConstraint.activate(descriptionConstraint)
        
    }
    
    private func configureView(game:GameDetail){
        posterImage.image = game.image
        releasedLabel.text = game.released
        titleLabel.text = game.name
        ratingLabel.addStarFill(String(game.rating), pointSize: 17)
        descriptionLabel.text = game.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

extension DetailViewController {
    
    private func getDetailGame(_ id:Int) async {
        loadingView.isHidden = false
        defer{ loadingView.isHidden = true }
        let service = NetworkService.shared
        do {
            var result = try await service.getDetailGame(id)
            service.dowloadImage(url: result.bacgroundImage){image in
                DispatchQueue.main.async {
                    result.image = image
                    self.configureView(game: result)
                }
            }
        } catch {
            print("ERROR: \(error)")
        }
    }
    
}
