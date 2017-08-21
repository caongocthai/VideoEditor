//
//  PreviewEffectsCollectionViewCell.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 9/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 This is the custom cell to display preview effects
 */
class PreviewEffectsCollectionViewCell: UICollectionViewCell {
    
    // The cell contains of a preview image and a tool name label
    let previewImageView: UIImageView = {
        let previewImageView = UIImageView()
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        return previewImageView
    }()
    
    let previewLabel: UILabel = {
        let previewLabel = UILabel()
        previewLabel.translatesAutoresizingMaskIntoConstraints = false
        previewLabel.textColor = .white
        previewLabel.font = UIFont.boldSystemFont(ofSize: 18)
        previewLabel.textAlignment = .center
        return previewLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        // Add 2 parts and auto layout them
        self.addSubview(previewLabel)
        previewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        previewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        previewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        previewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(previewImageView)
        previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        previewImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        previewImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: previewLabel.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
