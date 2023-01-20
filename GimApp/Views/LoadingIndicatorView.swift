//
//  LoadingIndicatorView.swift
//  GimApp
//
//  Created by Apple on 20/01/23.
//

import UIKit

class LoadingIndicatorView: UIView{
    
    private let loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.color = UIColor(named: "RedColor")
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addViews()
        applyConstraint()
    }
    
    override func didAddSubview(_ subview: UIView) {
        loadingView.startAnimating()
    }
    
    private func setupView(){
        backgroundColor = UIColor(named: "WhiteColor")
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
    
    private func addViews(){
        addSubview(loadingView)
    }
    
    private func applyConstraint() {
        let loadingConstraint = [
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(loadingConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
