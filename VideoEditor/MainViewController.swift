//
//  MainViewController.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 6/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import AVKit
import AVFoundation
import MobileCoreServices

class MainViewController: UIViewController {
    
    // Create a custom transitioning animation object
    //   This is an instance of our CustomViewControllerAnimatedTransitioning class
    let transition = CustomViewControllerAnimatedTransitioning()
    
    // Create the Name Label to decorate the Initial Screen
    let videoEditorLabel: UILabel = {
        let videoEditorLabel = UILabel()
        videoEditorLabel.backgroundColor = UIColor(red: 11/255, green: 232/255, blue: 151/255, alpha: 1)
        videoEditorLabel.text = "VIDEO EDITOR"
        videoEditorLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 75)
        videoEditorLabel.textColor = .white
        videoEditorLabel.textAlignment = .center
        videoEditorLabel.numberOfLines = 0
        videoEditorLabel.translatesAutoresizingMaskIntoConstraints = false
        return videoEditorLabel
    }()
    
    // Create a button to capture a video from the camera
    let cameraButton: UIButton = {
        let cameraButton = UIButton(type: .system)
        cameraButton.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal), for: .normal)
        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
        cameraButton.layer.shadowColor = UIColor.gray.cgColor
        cameraButton.layer.shadowOffset = CGSize(width: 7, height: 7)
        cameraButton.layer.shadowOpacity = 1
        cameraButton.layer.shadowRadius = 4
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        return cameraButton
    }()
    
    // Create a button to open gallery
    let galleryButton: UIButton = {
        let galleryButton = UIButton(type: .system)
        galleryButton.setImage(#imageLiteral(resourceName: "gallery").withRenderingMode(.alwaysOriginal), for: .normal)
        galleryButton.layer.cornerRadius = galleryButton.frame.width/2
        galleryButton.layer.shadowColor = UIColor.gray.cgColor
        galleryButton.layer.shadowOffset = CGSize(width: 7, height: 7)
        galleryButton.layer.shadowOpacity = 1
        galleryButton.layer.shadowRadius = 4
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        return galleryButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        // Add the App Name Label as well as the two buttons
        addVideoEditorLabel()
        addButtons()
    }
    
    // Helper function to add and auto layout the App Name Label
    func addVideoEditorLabel() {
        self.view.addSubview(videoEditorLabel)
        videoEditorLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoEditorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        videoEditorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        videoEditorLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
    }
    
    // Helper function to add and auto layout the two buttons
    func addButtons() {
        self.view.addSubview(cameraButton)
        cameraButton.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height*3/4).isActive = true
        cameraButton.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width/2 - 15).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cameraButton.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)
        
        self.view.addSubview(galleryButton)
        galleryButton.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height*3/4).isActive = true
        galleryButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width/2 + 15).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        galleryButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        galleryButton.addTarget(self, action: #selector(galleryTapped), for: .touchUpInside)
        
    }
}

/**
 Conform to 2 Delegate Protocol for further opening Gallery
 */
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Handle the touch event on the gallery button
    func galleryTapped() {
        let videoPickerController = UIImagePickerController()
        videoPickerController.delegate = self
        videoPickerController.transitioningDelegate = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false { return }
        videoPickerController.allowsEditing = true
        videoPickerController.sourceType = .photoLibrary
        videoPickerController.mediaTypes = [kUTTypeMovie as String]
        videoPickerController.modalPresentationStyle = .custom
        self.present(videoPickerController, animated: true, completion: nil)
    }
    
    // Handle the touch event on the camera button
    func cameraTapped() {
        let videoPickerController = UIImagePickerController()
        videoPickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            let alert = UIAlertController(title: "Camera Not Available", message: "Please press OK to continue", preferredStyle: .alert)
            alert.addAction(UIKit.UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        videoPickerController.allowsEditing = true
        videoPickerController.sourceType = .camera
        videoPickerController.cameraCaptureMode = .video
        videoPickerController.modalPresentationStyle = .fullScreen
        self.present(videoPickerController, animated: true, completion: nil)
    }
    
    // After picking a video, we dismiss the picker view controller and present the editor view controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let videoURL = info["UIImagePickerControllerReferenceURL"] as? URL
        self.dismiss(animated: true, completion: nil)
        
        // We create a VideoEditorViewController to play video as well as for editing purpose
        let videoEditorViewController = VideoEditorViewController()
        videoEditorViewController.videoURL = videoURL
        videoEditorViewController.videoAsset = AVURLAsset(url: videoURL!)
        videoEditorViewController.transitioningDelegate = self
        self.present(videoEditorViewController, animated: true, completion: nil)
    }
}

/**
 Conform to UIViewControllerTransitioningDelegate to performs custom transisioning animation
 */
extension MainViewController: UIViewControllerTransitioningDelegate {
    
    // Custom presentation animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.shrinkedPoint = galleryButton.center
        transition.transitionMode = .present
        return transition
    }
    
    // Custom dismission animation
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.shrinkedPoint = galleryButton.center
        transition.transitionMode = .dismiss
        return transition
    }
}
