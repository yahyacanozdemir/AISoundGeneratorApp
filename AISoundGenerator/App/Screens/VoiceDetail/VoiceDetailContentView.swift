//
//  VoiceDetailContentView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

protocol VoiceDetailDelegate: AnyObject {
  func showErrorPopup(title: String?, message: String?)
}

class VoiceDetailContentView: BaseView {
  
  init(voiceUrl: String) {
    self.voiceUrl = voiceUrl
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  weak var delegate: VoiceDetailDelegate?

  
  private var voiceUrl: String
  
  private lazy var voicePlayer = VoicePlayerView(voiceUrl: voiceUrl, voiceImageUrl: "voiceCover")
  
  private lazy var promptLabel : UILabel = {
    let label = UILabel()
    label.text = "Text"
    label.font = UIFont.Typography.title1
    label.textColor = .white
    return label
  }()
  
  private lazy var userPromptTextView = PromptInputView(onlyShowPrompt: true, initialPrompt: "Lo-Fi music, deep, smooth synthwave with a dream like  atmosphere")
  
  private lazy var downloadButton: BaseButton = {
    let button = BaseButton()
    button.title = "Download"
    button.titleColor = .papcornsWhite
    button.titleLabel?.font = UIFont.Typography.bodyBld
    button.addRadius(10)
    button.isGradientButton = true
    
    button.onTap = { [weak self] in

    }
    return button
  }()
  
  override func setupSubviews()  {
    addSubview(voicePlayer)
    addSubview(promptLabel)
    addSubview(userPromptTextView)
    addSubview(downloadButton)
  }
  
  override func setupConstraints() {
    voicePlayer.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(470)
    }
    promptLabel.snp.makeConstraints { make in
      make.top.equalTo(voicePlayer.snp.bottom).offset(34)
      make.horizontalEdges.equalToSuperview().inset(16)
    }
    userPromptTextView.snp.makeConstraints { make in
      make.top.equalTo(promptLabel.snp.bottom).offset(12)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(130)
      make.bottom.equalTo(downloadButton.snp.top).offset(-23)
    }
    downloadButton.snp.makeConstraints { make in
      make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(64)
    }
  }
}

