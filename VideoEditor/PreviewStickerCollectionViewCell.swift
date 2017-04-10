//
//  PreviewStickerCollectionViewCell.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 9/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 This is the custom cell to display preview sticker
 */
class PreviewStickerCollectionViewCell: UICollectionViewCell {
    // This view contains a image displaying the sticker
    let previewImageView: UIImageView = {
        let previewImageView = UIImageView()
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.contentMode = .scaleAspectFit
        return previewImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        // Add the preview image and auto layout it.
        self.addSubview(previewImageView)
        previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        previewImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        previewImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
