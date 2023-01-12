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
        image.image = UIImage(systemName:"magnifyingglass")
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named:"WhiteColor")
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var searchClick: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(searchImage)
        addSubview(containerView)
        
        applyConstraints()
    }
    
    public func setSearchOnClick(_ searchClick: (()->())?){
        self.searchClick = searchClick
    }
    
    private func setupView(){
        backgroundColor = UIColor(named: "BlackColor")
        
        searchImage.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(onSearchClicked)
        ))
    }
    
    private func applyConstraints() {
        
        let containerConstraints = [
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(containerConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSearchClicked(gesture:UIGestureRecognizer){
        if searchClick == nil { return }
        searchClick!()
    }
    
}
