//
//  PromptInputView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 1.11.2024.
//

import UIKit

class PromptInputView: BaseView {
  
  private var maxCharacterCount = 140
  
  var userPromptDidChanged: (() -> Void)?
  
  var userPromptText: String? {
    didSet { clearPromptButton.isHidden = userPromptText == nil || userPromptText == "" }
  }
  
  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.textColor = .papcornsWhite
    textView.backgroundColor = .papcornsDark
    textView.textColor = .papcornsWhite
    textView.font = UIFont.Typography.body
    textView.textContainer.maximumNumberOfLines = 4
    textView.textContainerInset = .init(top: 16, left: 16, bottom: 32, right: 16)
    textView.delegate = self
    textView.isScrollEnabled = false
    textView.showsVerticalScrollIndicator = false
    textView.addRadius(10)
    
    textView.addSubview(textViewPlaceHolderLabel)
    textView.addSubview(inspirationButton)
    textView.addSubview(inspirationImageView)
    textView.addSubview(clearPromptButton)
    return textView
  }()
  
  private lazy var textViewPlaceHolderLabel: UILabel = {
    let label = UILabel()
    label.text = "Write a text and let AI turn it into a speech with the voice of your favorite character"
    label.font = UIFont.Typography.body
    label.textColor = .papcornsWhite50
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()
  
  private lazy var inspirationButton: BaseButton = {
    let button = BaseButton()
    button.title = "Get inspiration"
    button.titleLabel?.font = UIFont.Typography.bodyBld
    button.backgroundColor = .clear
    button.titleColor = .papcornsPink
    button.isUnderlined = true
    button.onTap = { [weak self] in
      self?.textView.text = InspirationsData.getRandomInspiration()
      self?.textViewPlaceHolderLabel.isHidden = true
      self?.userPromptText = self?.textView.text
      self?.userPromptDidChanged?()
    }
    return button
  }()
  
  private lazy var inspirationImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "inspirationIcon")
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  private lazy var clearPromptButton: BaseButton = {
    let button = BaseButton()
    let btnImage = UIImage(named: "xIcon")
    button.setImage(btnImage, for: .normal)
    button.backgroundColor = .clear
    button.isHidden = true
    button.onTap = { [weak self] in
      self?.textView.text = ""
      self?.userPromptText = ""
      self?.textViewPlaceHolderLabel.isHidden = false
      self?.textView.endEditing(true)
      self?.userPromptDidChanged?()
    }
    return button
  }()
  
  override func setupSubviews() {
    addSubview(textView)
  }
  
  override func setupConstraints() {
    textView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    textViewPlaceHolderLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16)
      make.leading.equalToSuperview().offset(20)
      make.width.equalTo(textView.snp.width).offset(-32)
    }
    
    inspirationButton.snp.makeConstraints { make in
      make.top.equalTo(textViewPlaceHolderLabel.snp.bottom).offset(42)
      make.bottom.equalToSuperview().offset(-18)
      make.leading.equalToSuperview().offset(20)
    }
    
    inspirationImageView.snp.makeConstraints { make in
      make.centerY.equalTo(inspirationButton.snp.centerY)
      make.leading.equalTo(inspirationButton.snp.trailing).offset(4)
      make.width.height.equalTo(18)
    }
    
    clearPromptButton.snp.makeConstraints { make in
      make.centerY.equalTo(inspirationButton.snp.centerY)
      make.trailing.equalTo(textViewPlaceHolderLabel.snp.trailing)
    }
  }
}

extension PromptInputView: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    textViewPlaceHolderLabel.isHidden = !textView.text.isEmpty
    userPromptText = textView.text
    userPromptDidChanged?()
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let newText = textView.text!
    return (newText.count + text.count) <= maxCharacterCount
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    textViewPlaceHolderLabel.isHidden = !textView.text.isEmpty
  }
  func textViewDidBeginEditing(_ textView: UITextView) {
    textViewPlaceHolderLabel.isHidden = true
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(paste(_:)) {
      return false
    }
    return super.canPerformAction(action, withSender: sender)
  }
}
