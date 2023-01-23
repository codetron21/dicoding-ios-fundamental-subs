//
//  AboutViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class AboutViewController: UIViewController {
    
    private let photoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AdaPhoto")
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor(named: "RedColor")?.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 70
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Adadua karunia putera"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "WhiteColor")
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "adasoraninda@gmail.com"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "WhiteColor")
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        applyConstraint()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")
        
        stackView.addArrangedSubview(photoView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        
        view.addSubview(stackView)

        navigationItem.title = "About"
    }
    
    private func applyConstraint(){        
        let photoConstraint = [
            photoView.heightAnchor.constraint(equalToConstant: 140),
            photoView.widthAnchor.constraint(equalToConstant: 140)
        ]
        
        let stackConstraint = [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(photoConstraint)
        NSLayoutConstraint.activate(stackConstraint)
    }
    
}
