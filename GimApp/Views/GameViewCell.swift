//
//  GameViewCell.swift
//  GimApp
//
//  Created by Irsyad Purbha on 19/01/23.
//

import UIKit

class GameViewCell: UICollectionViewCell {
    
    private let posterImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(named: "RedColor")
        image.layer.cornerRadius = 4
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 1
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 1
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addViews()
        applyConstraint()
    }
    
    private func addViews(){
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releasedLabel)
        contentView.addSubview(ratingLabel)
    }
    
    private func applyConstraint(){
        let posterConstraint = [
            posterImage.widthAnchor.constraint(equalToConstant: 80),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: 4),
            titleLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 0)
        ]
        
        let ratingConstraint = [
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let releasedConstraint = [
            releasedLabel.topAnchor.constraint(equalTo: topAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(posterConstraint)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(ratingConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
