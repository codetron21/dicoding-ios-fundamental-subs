//
//  AboutViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class AboutViewController: UIViewController {

    private let photoView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel:UILabel = {
       let label = UILabel()
        label.text = "Adadua karunia putera"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel:UILabel = {
        let label = UILabel()
        label.text = "adasoraninda@gmail.com"
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView:UIStackView = {
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
        view.backgroundColor = UIColor(named: "Black2Color")
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(photoView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
    }
    
    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let stackConstraint = [
            stackView.topAnchor.constraint(equalTo: safeGuide.topAnchor ),
            stackView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(stackConstraint)
    }

}
