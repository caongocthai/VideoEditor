//
//  VideoPlayerView.swift
//  VideoEditor
//
//  Created by Thai Cao Ngoc on 6/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import AVKit
import AVFoundation

class VideoPlayerView: UIView {

    // Properties for displaying video and for funcioning well
    var videoURL: URL!
    var player: AVPlayer!
    var currentPlayingTime: CMTime!
    var videoDuration: Double!
    
    // The player container
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    
    // The play and pause button
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(pausePlayTapped), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = true
    
    func pausePlayTapped() {
        if isPlaying {
            player.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    
    // The video length indicator
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    // Current time label
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    // The video slider
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.addTarget(self, action: #selector(handleSliderChange), for: UIControlEvents.valueChanged)
        return slider
    }()
    
    func handleSliderChange() {
        if let duration = self.player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let timeValue = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(timeValue), timescale: 1)
            player.seek(to: seekTime, completionHandler: {(completredSeek) in})
        }
    }
    
    
    
    // Run the video on a AVPlayer layer
    init(frame: CGRect, url: URL) {
        super.init(frame: frame)
        
        // Play the video on a AVPlayer layer
        self.videoURL = url
        self.backgroundColor = .black
        player = AVPlayer(url: self.videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player.play()
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        // Observe the current playing time for handing Slider as well as current time label.
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] currentTime in
            guard self != nil else {
                return
            }
            self?.currentPlayingTime = currentTime
            let currentSeconds = CMTimeGetSeconds(currentTime)
            let minutes = String(format: "%02d", Int(currentSeconds)/60)
            let seconds = String(format: "%02d", Int(currentSeconds)%60)
            self?.currentTimeLabel.text = "\(minutes):\(seconds)"
            if let duration = self?.player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                self?.videoSlider.value = Float(currentSeconds/totalSeconds)
                if currentSeconds == totalSeconds {
                    self?.pausePlayTapped()
                }
            }
        }
        
        
        // A container to cover the video player layer
        controlsContainerView.frame = frame
        self.addSubview(controlsContainerView)
        
        // Add pause-play button at the bottom left of the container
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        pausePlayButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 11).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add video length indicator at the bottom right of the container
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Add current time label at the bottom left next to the play-pause button
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: pausePlayButton.rightAnchor).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Add the length slider indicator at the bottom of the container, between other button and labels
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Add a gradient to make the player look better
        //  Just for fun
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.7, 1.2]
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    // Observe to get the total length of the video
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            controlsContainerView.backgroundColor = .clear
            
            if let duration = player.currentItem?.duration {
                self.videoDuration = CMTimeGetSeconds(duration)
                let minutes = String(format: "%02d", Int(self.videoDuration)/60)
                let seconds = String(format: "%02d", Int(self.videoDuration)%60)
                videoLengthLabel.text = "\(minutes):\(seconds)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Really inportant, to get rid of the Observer before being deallocated
    deinit {
        //Remove the Observer when the layer get deallocated
        player.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
    }

}
