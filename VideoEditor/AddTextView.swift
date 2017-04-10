//
//  AddTextView.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 8/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

/**
 This VIew will be displayed when users choose Add Text tool
 */
class AddTextView: UIView {
    
    let previewPositionCellID = "previewPositionCellID"
    
    var position: Int? = nil
    var selectedIndexPath: IndexPath? = nil
    
    // All parts needed in the VIew
    let addTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Text"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 21)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let inputTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.borderStyle = .roundedRect
        textFiled.clearButtonMode = .whileEditing
        return textFiled
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
    
    let flowLayout = UICollectionViewFlowLayout()
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
        
        // Create the previewCollectionView and configurate it
        previewPositionCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        previewPositionCollectionView.delegate = self
        previewPositionCollectionView.dataSource = self
        previewPositionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        previewPositionCollectionView.register(PreviewPositionCollectionViewCell.self, forCellWithReuseIdentifier: previewPositionCellID)
        
        // Nedd UITextField delegate to control keyboard
        inputTextField.delegate = self
        
        // Add all parts
        addAddTextLabel()
        addInputTextField()
        addPositionLabel()
        addCancelButton()
        addAddButton()
        addPreviewPositionCollectionView()
        setPreviewPositionCollectionViewScroll()
        
    }
    
    // Helper function add all parts and auto layout them
    func addAddTextLabel() {
        self.addSubview(addTextLabel)
        addTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        addTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        addTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        addTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addInputTextField() {
        self.addSubview(inputTextField)
        inputTextField.topAnchor.constraint(equalTo: addTextLabel.bottomAnchor, constant: 15).isActive = true
        inputTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addPositionLabel() {
        self.addSubview(positionLabel)
        positionLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 15).isActive = true
        positionLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        positionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        positionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func addCancelButton() {
        self.addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width/4).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func addAddButton() {
        self.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width/4).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        let previewCollectionViewLayout = previewPositionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
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
extension AddTextView: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    // Number of cells = number of positons
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    // Create ptototype cell, which is a PreviewPositionCollectionViewCell instance
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: previewPositionCellID, for: indexPath) as! PreviewPositionCollectionViewCell
        previewCell.backgroundColor = .clear
        previewCell.previewImageView.image = UIImage(named: "position\(indexPath.row)")
        return previewCell
    }
    
    // Customize the size of a cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = 150
        let itemWidth = itemHeight*208/117
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // Handle cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            collectionView.cellForItem(at: selectedIndexPath!)?.backgroundColor = .clear
        }
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
        selectedIndexPath = indexPath
        position = indexPath.row
    }
    
}

// Conform to ITextFieldDelegate  to controll keyboard
extension AddTextView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
