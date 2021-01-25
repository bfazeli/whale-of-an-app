//
//  WhaleContentView.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/22/21.
//

import UIKit

class WhaleVerticalContentView: UIView, UIContentView {
  private var currentConfiguration: WhaleContentConfiguration!
  var configuration: UIContentConfiguration {
    get {
      currentConfiguration
    }
    set {
      guard let newConfiguration = newValue as? WhaleContentConfiguration else {
        return
      }
      apply(newConfiguration)
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = .white
    iv.image = UIImage(systemName: Constants.PHOTO)
    
    return iv
  }()
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: Constants.FONT_REGULAR)
    label.textAlignment = .center
    return label
  }()
  
  
  init(configuration: WhaleContentConfiguration) {
    super.init(frame: .zero)
    apply(configuration)
    setUpViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.INIT_CODER_ERROR)
  }
}

private extension WhaleVerticalContentView {
  private func setUpViews() {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
    ])
    
    stackView.spacing = Constants.SPACING
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(nameLabel)
  }
  
  private func apply(_ configuration: WhaleContentConfiguration) {
    guard currentConfiguration != configuration else { return }
    currentConfiguration = configuration
    nameLabel.text = configuration.name
    imageView.image = configuration.image
  }
}

