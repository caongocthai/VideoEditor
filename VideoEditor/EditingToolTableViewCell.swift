//
//  EditingToolTableViewCell.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 7/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit


/**
 Custom Table View Cell for tools Table View
 */
class EditingToolTableViewCell: UITableViewCell {
    
    // An image of the toll
    let toolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // A label that names the toll
    let toolNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.init(name: "HelveticaNeue", size: 19)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        // Add the image and auto layout it
        self.addSubview(toolImageView)
        toolImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        toolImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        toolImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
        toolImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        
        // Add the name label and auto layout it
        self.addSubview(toolNameLabel)
        toolNameLabel.leftAnchor.constraint(equalTo: toolImageView.rightAnchor, constant: 15).isActive = true
        toolNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        toolNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
