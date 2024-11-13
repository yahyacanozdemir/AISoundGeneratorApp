//
//  HomeContentView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

protocol HomeContentViewDelegate: AnyObject {
  func generateButtonTapped(userData: VoiceGenerateParameters)
}

class HomeContentView: BaseView {
  
  private let viewModel: HomeViewModel
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  weak var delegate: HomeContentViewDelegate?

  private lazy var userPromptTextView: PromptInputView = {
    let input = PromptInputView(onlyShowPrompt: false)
    input.userPromptDidChanged = {
      self.viewModel.userPrompt = input.userPromptText
      self.viewModel.isContinuable()
    }
    return input
  }()

  private lazy var voiceSelectionLabel : UILabel = {
    let label = UILabel()
    label.text = "Pick a Voice"
    label.font = UIFont.Typography.heading2
    label.textColor = .papcornsWhite
    return label
  }()
  
  private lazy var contentLoadingView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.color = .papcornsPink
    indicator.startAnimating()
    return indicator
  }()
  
  private lazy var categoriesCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(with: CategoryCell.self)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.allowsMultipleSelection = false
    return collectionView
  }()

  private lazy var voicesCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 10
    layout.itemSize = CGSize(width: 100, height: 140)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(with: VoiceCell.self)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.allowsMultipleSelection = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    return collectionView
  }()
  
  private lazy var continueButton: BaseButton = {
    let button = BaseButton()
    button.title = "Continue"
    button.titleColor = .papcornsWhite
    button.titleLabel?.font = UIFont.Typography.heading3
    button.addRadius(10)
    button.isDisabled = true
    button.isGradientButton = true
    
    button.onTap = {
      guard let promp = self.userPromptTextView.userPromptText, let cover = self.viewModel.selectedVoiceName else { return }
      let userData = VoiceGenerateParameters(promp: promp, cover: cover)
      self.delegate?.generateButtonTapped(userData: userData)
    }
    return button
  }()
    
  override func setupSubviews() {    
    [userPromptTextView, voiceSelectionLabel, contentLoadingView, categoriesCollectionView, voicesCollectionView, continueButton].forEach{ addSubview($0)}
  }
  
  override func setupConstraints() {
    userPromptTextView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.horizontalEdges.equalToSuperview().inset(12)
      make.height.equalTo(140)
    }
    
    voiceSelectionLabel.snp.makeConstraints { make in
      make.top.equalTo(userPromptTextView.snp.bottom).offset(16)
      make.horizontalEdges.equalToSuperview().inset(16)
    }
    
    contentLoadingView.snp.makeConstraints { make in
      make.top.equalTo(voiceSelectionLabel.snp.bottom).offset(64)
      make.centerX.equalToSuperview()
      make.height.equalTo(96)
    }
    
    categoriesCollectionView.snp.makeConstraints { make in
      make.top.equalTo(voiceSelectionLabel.snp.bottom).offset(12)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(42)
    }
    
    voicesCollectionView.snp.makeConstraints { make in
      make.top.equalTo(categoriesCollectionView.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.bottom.equalTo(continueButton.snp.top).offset(24)
    }
    
    continueButton.snp.makeConstraints { make in
      make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
      make.horizontalEdges.equalToSuperview().inset(16)
      make.height.equalTo(64)
    }
  }
  
  override func bind() {
    viewModel.delegate = self
    viewModel.loadVoices()
  }
  
  override func updateUI() {
    contentLoadingView.stopAnimating()
    contentLoadingView.isHidden = true
    
    categoriesCollectionView.reloadData()
    voicesCollectionView.reloadData()
    
    categoriesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
  }
}

//MARK: CollectionView Functions

extension HomeContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getCollectionItemCount(isCategoriesCollection: collectionView == categoriesCollectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == categoriesCollectionView {
      let cell =  collectionView.dequeueCell(withClassAndIdentifier: CategoryCell.self, for: indexPath)
      cell.name = viewModel.categories?[indexPath.row]
      return cell
    } else {
      let cell = collectionView.dequeueCell(withClassAndIdentifier: VoiceCell.self, for: indexPath)
      cell.voice = viewModel.createVoiceItemCellData(indexPath: indexPath)
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == categoriesCollectionView,
       let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell,
       let category = cell.name {
      viewModel.selectedCategoryName = category
      viewModel.selectedVoiceName = nil
      voicesCollectionView.reloadData()
      
      cell.isSelected = true
      
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      voicesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
      
    } else if let cell = collectionView.cellForItem(at: indexPath) as? VoiceCell {
      viewModel.selectedVoiceName = cell.voice?.name
      cell.isSelected = true
      collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    endEditing(true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard collectionView == categoriesCollectionView, let category = viewModel.categories?[indexPath.row] else {
      return CGSize(width: 100, height: 140)
    }
    
    let width = category.calculateLabelWidth(with: UIFont.Typography.bodyMd, maxHeight: 19) + 64
    return CGSize(width: width, height: 40)
  }
}

extension HomeContentView: HomeViewModelDelegate {
  func didUpdateCategories() {
    updateUI()
  }
  
  func didUpdateHomeContent() {
    updateUI()
  }
  
  func changeContinueButtonClickable(_ isClickable: Bool) {
    continueButton.isDisabled = !isClickable
  }
  
  func anErrorOccured(message: String) {
    // Bir hata meydana geldi
  }
}
