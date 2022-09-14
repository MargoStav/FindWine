//
//  FavoriteCell.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 13.09.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    
    let wineImageView = UIImageView()
    let wineNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: FavoriteWine, index: Int) {
        wineImageView.kf.setImage(with: URL(string: favorite.imageInfo.medium), placeholder: Images.placeholderImage, options: [.transition(.fade(0.3))])
      wineNameLabel.text = favorite.title
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
