//
//  PromptInputView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 1.11.2024.
//

import UIKit

class PromptInputView: BaseView {
  
  init(onlyShowPrompt: Bool, initialPrompt: String? = nil) {
    self.onlyShowPrompt = onlyShowPrompt
    self.initialPrompt = initialPrompt
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var maxCharacterCount = 140
  private var onlyShowPrompt: Bool
  private var initialPrompt: String?
  
  var userPromptDidChanged: (() -> Void)?
  
  var userPromptText: String? {
    didSet { clearPromptButton.isHidden = userPromptText == nil || userPromptText == "" }
  }
  
  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.textColor = .papcornsWhite
    textView.backgroundColor = .papcornsDark
    textView.textColor = .papcornsWhite
    textView.font = UIFont.Typography.bodyLg
    textView.textContainer.maximumNumberOfLines = 4
    textView.textContainerInset = .init(top: 16, left: 16, bottom: 32, right: 16)
    textView.delegate = self
    textView.isScrollEnabled = false
    textView.showsVerticalScrollIndicator = false
    textView.isEditable = !onlyShowPrompt
    textView.text = initialPrompt
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
    label.font = UIFont.Typography.bodyLg
    label.textColor = .papcornsWhite50
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .left
    label.isHidden = onlyShowPrompt
    return label
  }()
  
  private lazy var inspirationButton: BaseButton = {
    let button = BaseButton()
    button.title = "Get inspiration"
    button.titleLabel?.font = UIFont.Typography.subheading4
    button.backgroundColor = .clear
    button.titleColor = .papcornsPink
    button.isUnderlined = true
    button.isHidden = onlyShowPrompt
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
    view.image = UIImage.Catalog.inspirationIcon
    view.contentMode = .scaleAspectFit
    view.isHidden = onlyShowPrompt
    return view
  }()
  
  private lazy var clearPromptButton: BaseButton = {
    let button = BaseButton()
    let btnImage = UIImage.Catalog.xIcon
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
