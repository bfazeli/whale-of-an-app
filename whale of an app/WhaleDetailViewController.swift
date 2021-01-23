//
//  WhaleDetailViewController.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/23/21.
//

import UIKit

class WhaleDetailViewController: UIViewController {
  
  private var whaleName: String
  private var whaleImageData: Data
  
  init(name whaleName: String, imageData whaleImageData: Data) {
    self.whaleName = whaleName
    self.whaleImageData = whaleImageData
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.INIT_CODER_ERROR)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  private func setupLayout() {
    let whaleDetailView = WhaleVerticalContentView.init(frame: .zero)
    whaleDetailView.imageView.image = UIImage(data: whaleImageData)
    whaleDetailView.nameLabel.text = whaleName
    self.view.addSubview(whaleDetailView)
    
    whaleDetailView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      whaleDetailView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
      whaleDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
      whaleDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
      whaleDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
    ])
  }
}
