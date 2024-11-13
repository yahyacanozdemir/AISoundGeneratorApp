//
//  HomeCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

class HomeCoordinator: Coordinator {
  
  private var navigationController: BaseNavigationController
  
  required init(navigationController: BaseNavigationController) {
    self.navigationController = navigationController
  }
  
  func start(navigationType _: NavigationType) { }
  
  func start() {
    let repository = VoicesRepository()
    let useCase = HomeUseCase(voicesRepository: repository)
    let homeViewModel = HomeViewModel(useCase: useCase)
    
    let vc = HomeVC(
      contentView: HomeContentView(viewModel: homeViewModel))
    vc.coordinator = self
    navigationController.setViewControllers([vc], animated: false)
  }
}

extension HomeCoordinator {
  func navigateToVoiceGeneratingPage(userData: VoiceGenerateParameters) {
    let voiceGeneratingCoordinator = VoiceGeneratingCoordinator(navigationController: navigationController)
    voiceGeneratingCoordinator.start(userData: userData)
  }
}
