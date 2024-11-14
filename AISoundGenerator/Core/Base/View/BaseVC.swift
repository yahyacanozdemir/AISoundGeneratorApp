//
//  BaseVC.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit
import SnapKit


class BaseVC<T>: UIViewController, BindableLayout {
  
  // MARK: Lifecycle
  
  init(contentView: T) {
    self.contentView = contentView
    super.init(nibName: nil, bundle: nil)
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var contentView: T?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    (contentView as? BaseView)?.viewDidLoad()
    view.backgroundColor = .papcornsBlack
    setupUI()
    bind()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    (contentView as? BaseView)?.viewDidAppear()
  }

  override func viewDidDisappear(_: Bool) {
    let contentView = (contentView as? BaseView)
    contentView?.viewDidDisappear()
    if isMovingFromParent || isBeingDismissed {
      contentView?.viewDidKill()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    (contentView as? BaseView)?.viewWillAppear()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    (contentView as? BaseView)?.viewWillDisappear()
  }

  // MARK: - Layoutable
  
  func bind() {}

  final func setupUI() {
    setupSubviews()
    setupConstraints()
  }

  func setupSubviews() {
    if let contentView = (contentView as? BaseView) ?? (contentView as? UIView) {
      view.addSubview(contentView)
    }

    view.addSubview(statusBarView)
    if let selectedNavBar {
      view.addSubview(selectedNavBar)
    }
  }

  func setupConstraints() {
    let navigationBarHeight = selectedNavBar != nil ? 42 : 0

    if let contentView = (contentView as? BaseView) ?? (contentView as? UIView) {
      contentView.snp.makeConstraints { view in
        if !statusBarView.isHidden {
          view.top.equalTo(statusBarView.snp.bottom).offset(navigationBarHeight)
        } else {
          view.top.equalToSuperview().offset(navigationBarHeight)
        }
        view.leading.trailing.bottom.equalToSuperview()
      }
    }

    let statusBarHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame
      .height ?? 0
    statusBarView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(statusBarHeight)
    }

    if let selectedNavBar {
      selectedNavBar.snp.makeConstraints { make in
        make.top.equalTo(statusBarView.snp.bottom).offset(16)
        make.leading.trailing.equalToSuperview()
        make.height.equalTo(navigationBarHeight)
      }
    }
  }
  
  func updateUI() { }
  
  private lazy var statusBarView: UIView = {
    let statusBarView = UIView()
    statusBarView.backgroundColor = .black
    return statusBarView
  }()
  
  lazy var selectedNavBar: BaseView? = {
    let selectedNavBar = NavbarManager.placeNavbar(baseVC: self)
    if let selectedNavBar {
      selectedNavBar.backgroundColor = .black
      selectedNavBar.layer.cornerRadius = selectedNavBar.layer.cornerRadius
      selectedNavBar.clipsToBounds = true
      selectedNavBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    return selectedNavBar
  }()
}
