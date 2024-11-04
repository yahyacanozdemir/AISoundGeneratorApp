//
//  VoicePlayerView.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

import Foundation
import AVFoundation
import UIKit

class VoicePlayerView: BaseView {
  
  init(voiceUrl: String, voiceImageUrl: String) {
    self.voiceUrl = voiceUrl
    self.voiceImageUrl = voiceImageUrl
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  weak var delegate: VoiceDetailDelegate?
  
  var player: AVPlayer?
  var playerObserver: Any?
  
  private var voiceUrl: String
  private var voiceImageUrl: String
  
  private var playerItem: AVPlayerItem?
  private var isPlaying = false
  private var isLooping = false
  private var wasPlayingBeforeSeeking = false {
    didSet { tooglePlayButtonUI(wasPlayingBeforeSeeking)}
  }
  
  private lazy var voiceImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: voiceImageUrl)
    imgView.contentMode = .scaleAspectFill
    imgView.isUserInteractionEnabled = true
    imgView.addRadius(12)
    imgView.clipsToBounds = true
    return imgView
  }()
  
  private lazy var loopButton: BaseButton = {
    let btn = BaseButton()
    btn.setImage(UIImage(named: "loopDisable"), for: .normal)
    btn.onTap = { [ weak self ] in
      self?.loopButtonTap()
    }
    return btn
  }()
  
  private lazy var sliderProgressView: UISlider = {
    let slider = UISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.backgroundColor = .papcornsDark
    slider.tintColor = .papcornsWhite
    slider.setThumbImage(UIImage(named: "ellipseIcon"), for: .normal)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:)))
    slider.addGestureRecognizer(tapGesture)
    
    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    slider.addTarget(self, action: #selector(sliderTouchDown(_:)), for: .touchDown)
    slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchUpInside)
    return slider
  }()
  
  private lazy var playButton: BaseButton = {
    let btn = BaseButton()
    btn.setImage(UIImage(named: "playIcon"), for: .normal)
    btn.onTap = { [ weak self ] in
      self?.playButtonTap()
    }
    return btn
  }()
  
  private lazy var currentTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "0:00"
    label.textColor = .papcornsWhite
    label.font = UIFont.Typography.body2
    return label
  }()
  
  private lazy var durationLabel: UILabel = {
    let label = UILabel()
    label.text = "0:00"
    label.textColor = .papcornsWhite
    label.font = UIFont.Typography.body2
    return label
  }()
  
  
  override func setupSubviews()  {
    voiceImageView.addSubview(loopButton)
    [voiceImageView, playButton, sliderProgressView, currentTimeLabel, durationLabel].forEach { addSubview($0) }
    setupAudioPlayer()
  }
  
  override func setupConstraints() {
    voiceImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(400)
    }
    
    loopButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-20)
      make.bottom.equalToSuperview().offset(-24)
      make.height.equalTo(40)
      make.width.equalTo(98)
    }
    
    sliderProgressView.snp.makeConstraints { make in
      make.centerY.equalTo(playButton)
      make.leading.equalToSuperview()
      make.height.equalTo(4)
    }
    
    playButton.snp.makeConstraints { make in
      make.top.equalTo(voiceImageView.snp.bottom).offset(16)
      make.leading.equalTo(sliderProgressView.snp.trailing).offset(20)
      make.trailing.equalToSuperview()
      make.height.equalTo(56)
      make.bottom.equalToSuperview()
    }
    
    currentTimeLabel.snp.makeConstraints { make in
      make.top.equalTo(sliderProgressView.snp.bottom).offset(12)
      make.leading.equalTo(sliderProgressView.snp.leading)
      make.bottom.equalToSuperview()
    }
    
    durationLabel.snp.makeConstraints { make in
      make.top.equalTo(sliderProgressView.snp.bottom).offset(12)
      make.trailing.equalTo(sliderProgressView.snp.trailing)
      make.bottom.equalToSuperview()
    }
  }
  
  private func setupAudioPlayer() {
    guard let url = URL(string: voiceUrl) else {
      print("invalid URL")
      return
    }
    
    playerItem = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: playerItem)
    
    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
    
    //TODO:
    playerItem?.asset.loadValuesAsynchronously(forKeys: ["duration"]) { [weak self] in
      DispatchQueue.main.async {
        if let duration = self?.playerItem?.duration {
          let seconds = CMTimeGetSeconds(duration)
          self?.sliderProgressView.maximumValue = Float(seconds)
          self?.durationLabel.text = self?.formatTime(seconds: seconds)
        }
      }
    }
    
    player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main) { [weak self] time in
      guard let self = self else { return }
      let currentTime = CMTimeGetSeconds(time)
      sliderProgressView.value = Float(currentTime)
      currentTimeLabel.text = self.formatTime(seconds: currentTime)
      
      // Eğer player son noktaya ulaştıysa ve looping aktifse başa dön
      if currentTime >= Double(self.sliderProgressView.maximumValue) {
        if isLooping {
          player?.seek(to: .zero)
          player?.play()
        } else {
          isPlaying = false
          player?.pause()
          sliderProgressView.value = 0
          currentTimeLabel.text = "00:00"
          tooglePlayButtonUI(true)
        }
      }
    }
  }
  
  private func playButtonTap() {
    isPlaying ? player?.pause() : player?.play()
    tooglePlayButtonUI(isPlaying)
    isPlaying.toggle()
  }
  
  private func loopButtonTap() {
    let btnImage = isLooping ? UIImage(named: "loopDisable") : UIImage(named: "loopEnable")
    loopButton.setImage(btnImage, for: .normal)
    isLooping.toggle()
 }
  
  @objc private func playerDidFinishPlaying() {
    if isLooping {
      player?.seek(to: .zero)
      player?.play()
    } else {
      isPlaying = false
      player?.pause()
      player?.seek(to: .zero)
      tooglePlayButtonUI(true)
      sliderProgressView.value = 0
      currentTimeLabel.text = "00:00"
    }
  }
  
  @objc private func sliderValueChanged(_ sender: UISlider) {
    let seconds = Double(sender.value)
    let targetTime = CMTime(seconds: seconds, preferredTimescale: 600)
    player?.seek(to: targetTime)
  }
  
  
  @objc private func sliderTouchDown(_ sender: UISlider) {
    if player?.timeControlStatus == .playing {
      wasPlayingBeforeSeeking = true
      isPlaying = false
      player?.pause()
    }
  }
  
  @objc private func sliderTouchUp(_ sender: UISlider) {
    if wasPlayingBeforeSeeking {
      wasPlayingBeforeSeeking = false
      player?.play()
      isPlaying = true
    }
  }
  
  @objc private func sliderTapped(_ gesture: UITapGestureRecognizer) {
    let location = gesture.location(in: sliderProgressView)
    let sliderWidth = sliderProgressView.bounds.width
    let newValue = Float(location.x / sliderWidth) * sliderProgressView.maximumValue
    
    sliderProgressView.setValue(newValue, animated: true)
    sliderValueChanged(sliderProgressView)
  }
  
  private func formatTime(seconds: Double) -> String {
    let mins = Int(seconds) / 60
    let secs = Int(seconds) % 60
    return String(format: "%02d:%02d", mins, secs)
  }
  
  private func tooglePlayButtonUI(_ playing: Bool){
    let btnImage = playing ? UIImage(named: "playIcon") : UIImage(named: "pauseIcon")
    playButton.setImage(btnImage, for: .normal)
  }
}
