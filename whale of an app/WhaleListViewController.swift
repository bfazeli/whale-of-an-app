//
//  ViewController.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/21/21.
//

import UIKit

class WhaleListViewController: UIViewController {
  private let viewModel = ViewModel()
  private lazy var collectionView = configureCollectionView()
  private lazy var dataSource = configureDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    applyInitialSnapshot()
    viewModel.bindableReloadCollectionView.bind { [unowned self] (shouldReloadCV) in
      if shouldReloadCV == true {
        applyInitialSnapshot()
      }
    }
  }
  
  private func setupCollectionView() {
    collectionView.dataSource = dataSource
    view.addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
    ])
    collectionView.delegate = self
  }
}

private extension WhaleListViewController {
  func configureCollectionView() -> UICollectionView {
    UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
  }
  /// - Tag: CreateLayout
  func createLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let section: NSCollectionLayoutSection
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
      
      section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  /// - Tag: CreateDiffableDataSource
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Whale> {
    let cellRegistration = UICollectionView.CellRegistration<WhaleCollectionViewCell, Whale> { cell, indexPath, whaleData in
      cell.whaleData = whaleData
    }
    return UICollectionViewDiffableDataSource<Section, Whale> (
      collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, identifier: Whale) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
    }
  }
  
  /// - Tag: CreateSnapshot
  func applyInitialSnapshot() {
    let whales: [Whale] = viewModel.listOfWhales
    var whalesSnapshot = NSDiffableDataSourceSectionSnapshot<Whale>()
    whalesSnapshot.append(whales)
    dataSource.apply(whalesSnapshot, to: .main, animatingDifferences: false)
  }
  
  
  enum Section: CaseIterable {
    case main
  }
}

extension WhaleListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let whaleName = self.dataSource.itemIdentifier(for: indexPath)?.name ,
          let whaleImageData = self.dataSource.itemIdentifier(for: indexPath)?.imageData else {
      collectionView.deselectItem(at: indexPath, animated: true)
      return
    }
    
    let detailViewController = WhaleDetailViewController(name: whaleName, imageData: whaleImageData)
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
}
