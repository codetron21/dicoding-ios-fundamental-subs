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
        return image
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addViews()
        applyConstraint()
    }
    
    private func addViews(){
        contentView.addSubview(posterImage)
    }
    
    private func applyConstraint(){
        let posterConstraint = [
            posterImage.widthAnchor.constraint(equalToConstant: 80),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(posterConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
