//
//  WineImageView.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 02.09.2022.
//

import UIKit

class WineImageView: UIImageView {
    
    let placeholderImage = Images.placeholderImage
   

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
    
}
