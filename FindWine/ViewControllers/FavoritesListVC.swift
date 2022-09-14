//
//  FavoritesListVC.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 26.08.2022.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [FavoriteWine] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemRed
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                self.updateUI(with: favorites)
              
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func updateUI(with favorites: [FavoriteWine]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "You have no favorites wine", in: self.view)
        } else {
            self.favorites = favorites
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
                                   
   func showEmptyStateView(with message: String, in view: UIView) {
     let emptyStateView = FWEmptyStateView(message: message)
       emptyStateView.frame = view.bounds
       view.addSubview(emptyStateView)
        
    }

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { error in
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            print(error.rawValue)
        }
    }
    
    
}
