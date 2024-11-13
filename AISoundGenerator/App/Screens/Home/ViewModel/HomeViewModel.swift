//
//  HomeViewModel.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 13.11.2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
  func didUpdateCategories()
  func didUpdateHomeContent()
  func changeContinueButtonClickable(_ isClickable: Bool)
  func anErrorOccured(message: String)
}

class HomeViewModel {
  
  private let useCase: HomeUseCase
  
  init(useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  var homeContent: [String: [VoiceItem?]?]?
  var categories: [String]?
  var selectedCategoryName: String? = "Tümü"
  
  var userPrompt: String? {
    didSet { isContinuable() }
  }
  var selectedVoiceName: String? {
    didSet { isContinuable() }
  }
  
  
  weak var delegate: HomeViewModelDelegate?
  
  func loadVoices() {
    useCase.execute(completion: { [weak self] result in
      switch result {
      case .fetchProductDetailsuccess(let voices):
        self?.categories = self?.useCase.getCategories(data: voices)
        self?.delegate?.didUpdateCategories()
        
        self?.homeContent = self?.useCase.getObjectsByCategory(data: voices)
        self?.delegate?.didUpdateHomeContent()
      case .fetchVoicesFail:
        self?.delegate?.anErrorOccured(message: "Veri çekilirken hata meydana geldi")
      }
    })
  }
  
  func isContinuable() {
    self.delegate?.changeContinueButtonClickable(selectedVoiceName != nil && userPrompt.isNilOrBlank != true)
  }
  
  func getCollectionItemCount(isCategoriesCollection: Bool) -> Int {
    return isCategoriesCollection ? categories?.count ?? 0 : homeContent?[selectedCategoryName ?? ""]??.count ?? 0
  }
  
  func createVoiceItemCellData(indexPath: IndexPath) -> VoiceItem?  {
   return homeContent?[selectedCategoryName ?? ""]??[indexPath.row]
  }
}
