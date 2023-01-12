//
//  MainHeaderUIView.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class MainHeaderUIView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GIM APP"
        label.textColor = UIColor(named: "RedColor")
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named:"WhiteColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubview(titleLabel)
        addSubview(searchImage)
        applyConstraints()
    }
    
    private func setupView(){
        backgroundColor = UIColor(named: "BlackColor")
    }
    
    private func applyConstraints() {
        let titleConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let searchConstraints = [
            searchImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(searchConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
