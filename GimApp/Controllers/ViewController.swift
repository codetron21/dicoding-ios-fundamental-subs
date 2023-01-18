//
//  ViewController.swift
//  GimApp
//
//  Created by Apple on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let indicatorView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.color = UIColor.white
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = UIColor(named: "Black2Color")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupView()
        applyConstraint()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(named: "BlackColor")
        
        // set up navigation bar
        navigationItem.title = "Gim App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "RedColor") ?? UIColor.red]
        
        let itemAbout = UIBarButtonItem()
        itemAbout.image = UIImage(systemName: "person.circle")
        itemAbout.target = self
        itemAbout.action = #selector(actionAboutTap)
        
        navigationItem.rightBarButtonItem = itemAbout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func addViews() {
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
    }
    
    private func navigateToAbout(){
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
    private func applyConstraint(){
        let safeGuide = view.safeAreaLayoutGuide
        
        let collectionConstraint = [
            collectionView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ]
        
        let indicatorConstraint = [
            indicatorView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(indicatorConstraint)
        NSLayoutConstraint.activate(collectionConstraint)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension ViewController {
    
    @objc func actionAboutTap(){
        print("debug: about")
        navigateToAbout()
    }
    
}

