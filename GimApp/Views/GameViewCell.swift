//
//  GameViewCell.swift
//  GimApp
//
//  Created by Irsyad Purbha on 19/01/23.
//

import UIKit

class GameViewCell: UITableViewCell {
    
    var game: Game?{
        didSet {
            titleLabel.text = game?.name
            ratingLabel.text = String(game?.rating ?? 0)
            releasedLabel.text = game?.released
        }
    }
    
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
        label.textAlignment = .right
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupViews()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = UIColor(named:"Black2Color")
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
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            posterImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let ratingConstraint = [
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ]
        
        let releasedConstraint = [
            releasedLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
        ]
        
        NSLayoutConstraint.activate(posterConstraint)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(ratingConstraint)
        NSLayoutConstraint.activate(releasedConstraint)
    }
    
    
}
