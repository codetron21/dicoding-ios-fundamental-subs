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
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutImage: UIImageView = {
        let image = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        image.image = UIImage(systemName:"person.circle")
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named:"WhiteColor")
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var aboutClicked: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        applyConstraints()
    }
    
    public func setOnAboutClickListener(_ aboutClicked: (()->())?){
        self.aboutClicked = aboutClicked
    }
    
    private func setupView(){
        backgroundColor = UIColor(named: "BlackColor")
        
        aboutImage.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(onAboutClicked))
        )
    }
    
    private func applyConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onAboutClicked(gesture:UIGestureRecognizer){
        if aboutClicked == nil { return }
        aboutClicked!()
    }
    
}
