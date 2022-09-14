//
//  WineDescriptionVC.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import UIKit
import Kingfisher

class WineDescriptionVC: UIViewController {
    
    let wineImageView = UIImageView()
    let wineNameLabel = UILabel()
    let descriptionTextLabel = UILabel()
    var priceLabel = UILabel()
    let shareButton = UIButton()
    let addToFavoriteButton = UIButton()
    var wine: Wine?
   


    var priceFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        let doubleValue = (wine?.price.doubleValue ?? 0) / 100
        if let result = formatter.string(from: doubleValue as NSNumber) {
        return  result
    }
    return ""
}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        guard let wine = wine else {
            return
        }
        wineImageView.kf.setImage(with: URL(string: wine.imageInfo.large ), placeholder: Images.placeholderImage, options: [.transition(.fade(0.2))], completionHandler: nil)
        priceLabel.text = priceFormatted
        wineNameLabel.text = wine.title
        descriptionTextLabel.text = wine.description ?? ""
        
        shareButton.backgroundColor = .systemYellow
        shareButton.layer.cornerRadius = 17
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemRed
        shareButton.addTarget(self, action: #selector(presentShareSheets(_:)), for: .touchUpInside)
        
        addToFavoriteButton.backgroundColor = .systemRed
        addToFavoriteButton.layer.cornerRadius = 17
        wine.isFavorite ? addToFavoriteButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal) : addToFavoriteButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
        
        addToFavoriteButton.tintColor = .systemYellow
        addToFavoriteButton.addTarget(self, action: #selector(addToFavoritesList), for: .touchUpInside)
        

    }
    
    @objc func presentShareSheets(_ sender: UIButton) {
        guard let image = wine?.imageInfo.medium, let url = wine?.url else {
            return
        }
      let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
      
      shareSheetVC.popoverPresentationController?.sourceView = sender
      shareSheetVC.popoverPresentationController?.sourceRect = sender.frame
      present(shareSheetVC, animated: true)
    }
    
    @objc func addToFavoritesList() {
        guard var wine = wine else {
            return
        }
        let favorite = FavoriteWine(title: wine.title, imageInfo: wine.imageInfo)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
            guard let error = error else {
                let alert = UIAlertController(title: "Added to favorites list", message: "Press share button if you want to tell your friends about this wine", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                wine.isFavorite.toggle()
                return
            }
            print(error.rawValue)
        }
        
    }
    
    func layoutUI() {
        view.addSubview(wineImageView)
        view.addSubview(priceLabel)
        view.addSubview(wineNameLabel)
        view.addSubview(descriptionTextLabel)
        view.addSubview(shareButton)
        view.addSubview(addToFavoriteButton)
        
        wineNameLabel.lineBreakMode = .byWordWrapping
        descriptionTextLabel.lineBreakMode = .byWordWrapping
        descriptionTextLabel.numberOfLines = 0
        wineNameLabel.numberOfLines = 0
        priceLabel.textColor = .systemRed
        priceLabel.font = .boldSystemFont(ofSize: 20)
        
        wineImageView.translatesAutoresizingMaskIntoConstraints = false
        wineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            wineImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            wineImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            wineImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            wineImageView.heightAnchor.constraint(equalToConstant: 380),
            
            priceLabel.topAnchor.constraint(equalTo: wineImageView.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 300),
            priceLabel.widthAnchor.constraint(equalToConstant: 110),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            wineNameLabel.topAnchor.constraint(equalTo: wineImageView.bottomAnchor, constant: 50),
            wineNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            wineNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            wineNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionTextLabel.topAnchor.constraint(equalTo: wineNameLabel.bottomAnchor, constant: 10),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextLabel.heightAnchor.constraint(equalToConstant: 80),
            
            shareButton.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 100),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            addToFavoriteButton.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 10),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 80),
            addToFavoriteButton.widthAnchor.constraint(equalToConstant: 100),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
