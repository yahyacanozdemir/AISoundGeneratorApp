//
//  VoiceDetailContentView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

protocol VoiceDetailDelegate: AnyObject {
  func showPopup(title: String, message: String)
  func showShareSheet(_ fileUrl: URL)
}

class VoiceDetailContentView: BaseView {
  
  init(voiceUrl: String, voicePrompt: String) {
    self.voiceUrl = voiceUrl
    self.voicePromptText = voicePrompt
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func deinitVoicePlayer() {
    voicePlayer.deinitView()
  }
  
  weak var delegate: VoiceDetailDelegate?

  var voiceUrl: String
  var voicePromptText: String
  
  private lazy var voicePlayer: VoicePlayerView = {
    let view = VoicePlayerView(voiceUrl: voiceUrl, voiceImageUrl: "voiceCover")
    view.anErrorOccured = { [weak self] msg in
      self?.delegate?.showPopup(title: "Hata", message: msg.rawValue)
    }
    return view
  }()
  
  private lazy var promptLabel : UILabel = {
    let label = UILabel()
    label.text = "Text"
    label.font = UIFont.Typography.subheading2
    label.textColor = .papcornsWhite
    return label
  }()
  
  private lazy var userPromptTextView = PromptInputView(onlyShowPrompt: true, initialPrompt: voicePromptText)
  
  private lazy var downloadButton: BaseButton = {
    let button = BaseButton()
    button.title = "Download"
    button.titleColor = .papcornsWhite
    button.titleLabel?.font = UIFont.Typography.heading3
    button.addRadius(10)
    button.isGradientButton = true
    
    button.onTap = { [weak self] in
      self?.downloadAndShareVoice()
    }
    return button
  }()
  
  override func setupSubviews()  {
    [voicePlayer, promptLabel, userPromptTextView, downloadButton].forEach { addSubview($0) }
  }
  
  override func setupConstraints() {
    voicePlayer.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(470)
    }
    promptLabel.snp.makeConstraints { make in
      make.top.equalTo(voicePlayer.snp.bottom).offset(34)
      make.height.equalTo(32)
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

//MARK: Networking

extension VoiceDetailContentView {
  func downloadAndShareVoice() {
    guard let url = URL(string: voiceUrl) else { return }
    FullScreenIndicator.shared.showLoadingView(true, message: "Ses dosyası indiriliyor..")

    NetworkManager.shared.downloadAudio(from: url) { [weak self] result in
      switch result {
      case .success(let fileUrl):
        FullScreenIndicator.shared.showLoadingView(false)
        self?.delegate?.showShareSheet(fileUrl)
      case .failure(_):
        FullScreenIndicator.shared.showLoadingView(false)
        self?.delegate?.showPopup(title: "Hata", message: "Ses dosyası indirilirken hata meydana geldi.")
      }
    }
  }
}

