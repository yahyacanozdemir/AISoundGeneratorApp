//
//  VoiceGeneratingContentView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit
import AVFoundation

protocol VoiceGeneratingContentViewDelegate: AnyObject {
  func voiceGenerated(resultUrl: String, voicePrompt: String)
}

class VoiceGeneratingContentView: BaseView {

  init(_ userData: VoiceGenerateParameters) {
    self.userData = userData
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var userData: VoiceGenerateParameters
  weak var delegate: VoiceGeneratingContentViewDelegate?
    
  private lazy var animationBackgroundView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage.Catalog.gradientCircle
    view.contentMode = .scaleAspectFit
    view.layer.masksToBounds = false
    view.clipsToBounds = true
    return view
  }()
  
  private lazy var generatingImageView: UIImageView = {
    let icon = UIImageView()
    icon.image = UIImage.Catalog.generatingIcon
    icon.contentMode = .scaleAspectFit
    return icon
  }()
  
  private lazy var generatingTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Generating"
    label.font = UIFont.Typography.subheading1
    label.textAlignment = .center
    label.textColor = .papcornsWhite
    return label
  }()
  
  private lazy var generatingDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "It may take up to few minutes for you to receive an AI-generated speech. You can find your voice record in Library."
    label.font = UIFont.Typography.bodyMLg
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .papcornsWhite
    return label
  }()
  
  override func setupSubviews() {
    [animationBackgroundView, generatingImageView, generatingTitleLabel, generatingDescriptionLabel].forEach { addSubview($0) }
    
    animationEffect()
  }
  
  override func setupConstraints() {
    animationBackgroundView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(80)
      make.centerX.equalToSuperview()
      make.height.width.equalTo(236)
    }
    generatingImageView.snp.makeConstraints { make in
      make.centerY.equalTo(animationBackgroundView)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(236)
    }
    generatingTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(generatingImageView.snp.bottom).offset(102)
      make.horizontalEdges.equalToSuperview().inset(74)
      make.height.equalTo(42)
    }
    generatingDescriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(generatingTitleLabel.snp.bottom).offset(8)
      make.horizontalEdges.equalToSuperview().inset(74)
    }
  }
  
  override func bind() {
    networkDelegate = self
    generateVoice()
  }
  
  private func animationEffect() {
    UIView.animate(withDuration: 1.0, animations: {
      self.animationBackgroundView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
    }) { _ in
      UIView.animate(withDuration: 1.0, animations: {
        self.animationBackgroundView.transform = CGAffineTransform.identity
      }) { _ in
        self.animationEffect()
      }
    }
  }
}

//MARK: Networking

extension VoiceGeneratingContentView: NetworkDelegate {
  
  private func generateVoice() {
    let params = ["promp": userData.promp,
                  "cover": userData.cover]
    let request = BaseRequest(
      endpoint: .generateVoice,
      method: .post,
      parameters: params,
      parameterType: .body)
    sendRequest(request, responseType: VoiceResulEntity())
  }
  

  func networkDataReceived(_ data: Any?) {
    guard let response = data as? VoiceResulEntity, let resultUrl = response.resultUrl else { return }
    
    //MARK: Animasyon gözükmesi için fazladan 2sn eklenmiştir.
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
      self.delegate?.voiceGenerated(resultUrl: resultUrl, voicePrompt: self.userData.promp)
    })
  }
}
