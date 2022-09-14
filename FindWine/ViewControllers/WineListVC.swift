//
//  WineListVC.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import UIKit

class WineListVC: UIViewController, UICollectionViewDelegate {

    enum Section {
        case main
    }
    
    var wines: [Wine] = []
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Wine>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .systemRed
        configureCollectionView()
        configureDataSource()
        updateUI(with: wines)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width * 0.85, height: 200)
        layout.minimumLineSpacing = 16
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(WineCell.self, forCellWithReuseIdentifier: WineCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wineDescriptionVC = WineDescriptionVC()
        wineDescriptionVC.wine = wines[indexPath.item]
        navigationController?.pushViewController(wineDescriptionVC, animated: true)
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = FWEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func updateUI(with wines: [Wine]) {
        if  wines.isEmpty {
            let message = "Oops! METRO doesn't have this wine."
            showEmptyStateView(with: message, in: view)
            return
        }
        updateData(on: wines)
    }
    
    func configureDataSource() {
        guard let collectionView = collectionView else {
            return
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Wine>(collectionView: collectionView, cellProvider: { ( collectionView, indexPath, wine) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WineCell.reuseID, for: indexPath) as! WineCell
            cell.set(wine: wine)
            return cell
        })
    }
    
    
    func updateData(on wines: [Wine]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Wine>()
        snapshot.appendSections([.main])
        snapshot.appendItems(wines)
        dataSource.apply(snapshot)
    }
}

