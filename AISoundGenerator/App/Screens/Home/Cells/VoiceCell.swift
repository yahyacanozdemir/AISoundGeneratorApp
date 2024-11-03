//
//  VoiceCell.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class VoiceCell: BaseCollectionViewCell {
  
  override var isSelected: Bool {
    didSet {
      setSelected(isSelected)
    }
  }
  
  var voice: VoiceItem? {
    didSet {
      updateUI()
    }
  }
  
  private lazy var voiceImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var overlayLayer: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = UIColor.papcornsPurple30.cgColor
    layer.isHidden = true
    return layer
  }()
  
  private lazy var playingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "playingIcon")
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    return imageView
  }()
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.Typography.body
    label.textAlignment = .center
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    overlayLayer.frame = voiceImageView.bounds
  }
  
  override func setupSubviews() {
    voiceImageView.layer.addSublayer(overlayLayer)
    voiceImageView.addSubview(playingImageView)
    contentView.addSubview(voiceImageView)
    contentView.addSubview(label)
  }
  
  override func setupConstraints() {
    voiceImageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(contentView.snp.width)
    }
    
    playingImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
    
    label.snp.makeConstraints { make in
      make.top.equalTo(voiceImageView.snp.bottom).offset(5)
      make.leading.trailing.equalToSuperview()
    }
  }
  
  override func updateUI() {
    voiceImageView.setImage(voice?.imageUrl)
    label.text = voice?.name
  }
  
  private func setSelected(_ isSelected: Bool){
    if isSelected {
      voiceImageView.addBorder(color: .papcornsPink, width: 2)
      playingImageView.isHidden = false
      overlayLayer.isHidden = false
    } else {
      voiceImageView.removeBorder()
      playingImageView.isHidden = true
      overlayLayer.isHidden = true
    }
  }
}
