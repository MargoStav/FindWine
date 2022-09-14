//
//  WineCell.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import UIKit
import Kingfisher

class WineCell: UICollectionViewCell {
    static let reuseID = "wineCell"
    
    let wineImageView = UIImageView()
    let wineNameLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(wine: Wine) {
        wineImageView.kf.setImage(with: URL(string: wine.imageInfo.medium), placeholder: Images.placeholderImage, options: [.transition(.fade(0.3))])
      wineNameLabel.text = wine.title
    }
    
    private func configure() {
       addSubview(wineImageView)
       addSubview(wineNameLabel)
        
        wineNameLabel.lineBreakMode = .byWordWrapping
        wineNameLabel.numberOfLines = 0
        wineNameLabel.adjustsFontSizeToFitWidth = true
        wineNameLabel.textColor = .label
        wineNameLabel.isUserInteractionEnabled = true
        
        wineImageView.translatesAutoresizingMaskIntoConstraints = false
        wineNameLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            
            wineImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            wineImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            wineImageView.heightAnchor.constraint(equalToConstant: 180),
            wineImageView.widthAnchor.constraint(equalToConstant: 180),
            
            wineNameLabel.leadingAnchor.constraint(equalTo: wineImageView.trailingAnchor, constant: 5),
            wineNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wineNameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
