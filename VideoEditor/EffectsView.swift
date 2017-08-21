//
//  EffectsView.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 9/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 This View will be displayed when user choose Effects tool
 */
class EffectsView: UIView {

    let previewEffectsCellID = "previewEffectsCellID"
    let effectNames = ["Maple", "Passion", "Fall", "Fashion", "Memory", "Movies", "Greenish", "BvS", "Cyan", "Vista", "Faded", "Frozen", "Superia", "Twilight", "Lazy", "Youthful", "Calm", "Ektar", "Velvia"]
    
    
    var effect: Int? = nil
    var selectedIndexPath: IndexPath? = nil
    
    // All parts of the View
    let effectsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Effects"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 21)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    let flowLayout = UICollectionViewFlowLayout()
    var previewCollectionView: UICollectionView!
    
    
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
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
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
        
        // Create the previewCollectionView and configurate it
        previewCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        previewCollectionView.register(PreviewEffectsCollectionViewCell.self, forCellWithReuseIdentifier: previewEffectsCellID)
        
        // Add all parts
        addEffectsLabel()
        addCancelButton()
        addApplyButton()
        addPreviewCollectionView()
        setPreviewCollectionViewScroll()
        
    }
    
    // Heler function add all parts and auto layout them
    func addEffectsLabel() {
        self.addSubview(effectsLabel)
        effectsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        effectsLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        effectsLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        effectsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    
    func addCancelButton() {
        self.addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width/4).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func addApplyButton() {
        self.addSubview(applyButton)
        applyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        applyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width/4).isActive = true
        applyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func addPreviewCollectionView() {
        previewCollectionView.backgroundColor = .gray
        previewCollectionView.showsHorizontalScrollIndicator = false
        self.addSubview(previewCollectionView)
        previewCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        previewCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        previewCollectionView.topAnchor.constraint(equalTo: effectsLabel.bottomAnchor, constant: 5).isActive = true
        previewCollectionView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -5).isActive = true
    }
    
    func setPreviewCollectionViewScroll() {
        let previewCollectionViewLayout = previewCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        previewCollectionViewLayout?.scrollDirection = .horizontal
        previewCollectionViewLayout?.minimumLineSpacing = 20
        previewCollectionViewLayout?.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

/**
 Conform to these to customize the previewCollectionView
 */
extension EffectsView: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    // Number of cell = number of effects
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    // Create a prototype cell, which is an object of PreviewEffectCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: previewEffectsCellID, for: indexPath) as! PreviewEffectsCollectionViewCell
        let index = indexPath.row
        previewCell.backgroundColor = .clear
        previewCell.previewImageView.image = UIImage(named: "effect\(index)")
        previewCell.previewLabel.text = effectNames[index]
        return previewCell
    }
    
    // Customize the size of ech cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = 200
        let itemWidth = itemHeight*208/150
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // Handle cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            collectionView.cellForItem(at: selectedIndexPath!)?.backgroundColor = .clear
        }
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
        selectedIndexPath = indexPath
        effect = indexPath.row
    }
    
}
