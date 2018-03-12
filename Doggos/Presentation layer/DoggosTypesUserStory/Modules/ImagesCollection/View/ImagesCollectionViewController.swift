//
//  ImagesCollectionImagesCollectionViewController.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ImagesCollectionViewController: UIViewController, MessagesDisplayer {

  var output: ImagesCollectionViewOutput!
  
  private let collectionNode =
    ASCollectionNode(collectionViewLayout: ImagesCollectionViewController.collectionNodeFlowLayout())

  private var links = [ImageLinkContainer]()

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupCollectionNode()
    output.viewIsReady()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    updateCollectionNodeFrame()
  }
  
  // MARK: - Private
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage.navBarBackgroundImage(),
                                                                for: .default)
    self.navigationController?.navigationBar.shadowImage = nil
  }
  
  private func setupCollectionNode() {
    view.addSubnode(collectionNode)
    collectionNode.dataSource = self
    collectionNode.delegate = self
  }
  
  private func updateCollectionNodeFrame() {
    collectionNode.frame = view.bounds
  }

}

// MARK: - ASCollectionDelegate
extension ImagesCollectionViewController: ASCollectionDelegate {
  
  func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
    if let collectionImageNode = collectionNode.nodeForItem(at: indexPath) as? DoggoCollectionImageNode {
      if let image = collectionImageNode.reportDisplayingImage() {
        let viewContainingImage = collectionImageNode.reportDisplayingView()
        output.didTapCellWith(image: image, viewContainingImage: viewContainingImage)
      } else {
        displayErrorMessage(ModuleInternalError.timingError)
      }
    } else {
      displayErrorMessage(ModuleInternalError.castError)
    }
  }
  
}

// MARK: - ASCollectionDataSource
extension ImagesCollectionViewController: ASCollectionDataSource {
  
  func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
    return 1
  }
  
  func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    return links.count
  }
  
  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    var cellCreateBlock: ASCellNodeBlock = {
      return ASCellNode()
    }
    if links.indices.contains(indexPath.row) {
      let link = links[indexPath.row]
      cellCreateBlock = {
        let cell = DoggoCollectionImageNode(withLinkContainer: link)
        return cell
      }
    }
    return cellCreateBlock
  }
  
}

// MARK: - ImagesCollectionViewInput
extension ImagesCollectionViewController: ImagesCollectionViewInput {
  
  func configure(with imageLinks: [ImageLinkContainer]) {
    self.links = imageLinks
    collectionNode.reloadData()
  }
  
  func showError(_ error: Error?) {
    displayErrorMessage(error)
  }
}

// MARK: - Static functions
extension ImagesCollectionViewController {
  
  static func collectionNodeFlowLayout() -> UICollectionViewFlowLayout {
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 2, height: UIScreen.main.bounds.width/3 - 2)
    flowLayout.minimumInteritemSpacing = 1
    flowLayout.minimumLineSpacing = 1
    return flowLayout
  }
  
}
