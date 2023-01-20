//
//  DetailViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gameId:Int? = nil
    
    private let posterImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
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
        Task {await getDetailGame(id) }
    }
    
    private func addViews(){
        stackView.addSubview(posterImage)
        stackView.addSubview(releasedLabel)
        stackView.addSubview(titleLabel)
        stackView.addSubview(descriptionLabel)
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
        
    }
    
}

extension DetailViewController {
    
    func getDetailGame(_ id:Int) async {
        let service = NetworkService()
        do {
            try await service.getDetailGame(id)
        } catch {
            print("ERROR: \(error)")
        }
        
    }
}
