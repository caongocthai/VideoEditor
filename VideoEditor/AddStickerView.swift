//
//  AddStickerView.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 9/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 This VIew will be displayed when users choose Add Sticker tool
 */
class AddStickerView: UIView {
    let previewStickerCellID = "previewStickerCellID"
    let previewPositionCellID = "previewPositionCellID"
    
    var sticker: Int? = nil
    var position: Int? = nil
    var selectedStickerIndexPath: IndexPath? = nil
    var selectedPositionIndexPath: IndexPath? = nil
    
    // All parts needed in the View
    let stickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sticker"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 21)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Position"
        label.font = UIFont.init(name: "HelveticaNeue", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let previewStickerFlowLayout = UICollectionViewFlowLayout()
    var previewStickerCollectionView: UICollectionView!
    let previewPositionFlowLayout = UICollectionViewFlowLayout()
    var previewPositionCollectionView: UICollectionView!
    
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        
        // Create 2 collection view: 1 for displaying sticker, 1 for displaying added position
        previewStickerCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: previewStickerFlowLayout)
        previewStickerCollectionView.delegate = self
        previewStickerCollectionView.dataSource = self
        previewStickerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        previewStickerCollectionView.register(PreviewStickerCollectionViewCell.self, forCellWithReuseIdentifier: previewStickerCellID)
        
        previewPositionCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: previewPositionFlowLayout)
        previewPositionCollectionView.delegate = self
        previewPositionCollectionView.dataSource = self
        previewPositionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        previewPositionCollectionView.register(PreviewPositionCollectionViewCell.self, forCellWithReuseIdentifier: previewPositionCellID)
        
    
        // Add and auto layout all parts
        addStickerLabel()
        addPreviewStickerCollectionView()
        setPreviewStickerCollectionViewScroll()
        addPositionLabel()
        addCancelButton()
        addAddButton()
        addPreviewPositionCollectionView()
        setPreviewPositionCollectionViewScroll()
        
    }
    
    // Helper function to add and auto layout all parts
    func addStickerLabel() {
        self.addSubview(stickerLabel)
        stickerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stickerLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stickerLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stickerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addPreviewStickerCollectionView() {
        previewStickerCollectionView.backgroundColor = .gray
        previewStickerCollectionView.showsHorizontalScrollIndicator = false
        self.addSubview(previewStickerCollectionView)
        previewStickerCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        previewStickerCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        previewStickerCollectionView.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor).isActive = true
        previewStickerCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setPreviewStickerCollectionViewScroll() {
        let previewStickerCollectionViewLayout = previewStickerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        previewStickerCollectionViewLayout?.scrollDirection = .horizontal
        previewStickerCollectionViewLayout?.minimumLineSpacing = 10
        previewStickerCollectionViewLayout?.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
    }
    
    func addPositionLabel() {
        self.addSubview(positionLabel)
        positionLabel.topAnchor.constraint(equalTo: previewStickerCollectionView.bottomAnchor).isActive = true
        positionLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        positionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        positionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addCancelButton() {
        self.addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width/4).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addAddButton() {
        self.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width/4).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addPreviewPositionCollectionView() {
        previewPositionCollectionView.backgroundColor = .gray
        previewPositionCollectionView.showsHorizontalScrollIndicator = false
        self.addSubview(previewPositionCollectionView)
        previewPositionCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        previewPositionCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        previewPositionCollectionView.topAnchor.constraint(equalTo: positionLabel.bottomAnchor).isActive = true
        previewPositionCollectionView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -5).isActive = true
    }
    
    func setPreviewPositionCollectionViewScroll() {
        let previewPositionCollectionViewLayout = previewPositionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        previewPositionCollectionViewLayout?.scrollDirection = .horizontal
        previewPositionCollectionViewLayout?.minimumLineSpacing = 20
        previewPositionCollectionViewLayout?.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/**
 Conform to these to customize the previewCollectionView
 */
extension AddStickerView: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    // Number of cell for each collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == previewStickerCollectionView {
            return 23
        } else {
            return 9
        }
    }
    
    // Create prototype cell for each collection VIew
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cells of previewStickerCollectionView are PreviewStickerCollectionViewCell instances
        if collectionView == previewStickerCollectionView {
            let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: previewStickerCellID, for: indexPath) as! PreviewStickerCollectionViewCell
            previewCell.backgroundColor = .clear
            previewCell.previewImageView.image = UIImage(named: "sticker\(indexPath.row)")
            return previewCell
        } else {
            let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: previewPositionCellID, for: indexPath) as! PreviewPositionCollectionViewCell
            previewCell.backgroundColor = .clear
            previewCell.previewImageView.image = UIImage(named: "position\(indexPath.row)")
            return previewCell
        }
    }
    
    // Size for a cell of each collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == previewStickerCollectionView {
            return CGSize(width: 100, height: 100)
        } else {
            let itemHeight = 150
            let itemWidth = itemHeight*208/117
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    // Handle cell selection for each collection View
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == previewStickerCollectionView {
            if selectedStickerIndexPath != nil {
                collectionView.cellForItem(at: selectedStickerIndexPath!)?.backgroundColor = .clear
            }
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
            selectedStickerIndexPath = indexPath
            sticker = indexPath.row
        } else {
            if selectedPositionIndexPath != nil {
                collectionView.cellForItem(at: selectedPositionIndexPath!)?.backgroundColor = .clear
            }
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
            selectedPositionIndexPath = indexPath
            position = indexPath.row
        }
    }
}
