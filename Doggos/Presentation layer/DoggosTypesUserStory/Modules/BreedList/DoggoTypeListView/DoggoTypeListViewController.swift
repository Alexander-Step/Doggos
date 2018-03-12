//
//  BreedListBreedListViewController.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DoggoTypeListViewController: UIViewController, MessagesDisplayer {
  var output: DoggoTypeListViewOutput!
  
  private let tableNode = ASTableNode()
  
  var doggosTypes = [DoggoType]()

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupTableNode()
    output.viewIsReady()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    updateTableNodeFrame()
  }

  // MARK: - Private
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage.navBarBackgroundImage(),
                                                                for: .default)
    self.navigationController?.navigationBar.shadowImage = nil
  }
  
  private func setupTableNode() {
    view.addSubnode(tableNode)
    tableNode.dataSource = self
    tableNode.delegate = self
  }
  
  private func updateTableNodeFrame() {
    tableNode.frame = view.bounds
  }
  
  @objc func rightNavBarActionOnBreedList() {
    output.didTapOpenSelectFlowScreen()
  }

}

// MARK: - BreedListViewInput
extension DoggoTypeListViewController: DoggoTypeListViewInput {
  
  func configure(with doggoTypes: [DoggoType]) {
    self.doggosTypes = doggoTypes
    tableNode.reloadData()
  }
  
  func showError(_ error: Error?) {
    displayErrorMessage(error)
  }
  
  func configureNavigationItemForBreedList() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.doggoFace(),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(rightNavBarActionOnBreedList))
  }
  
  func configureTitleForBreedList() {
    self.navigationItem.title = "Breeds"
  }
  
  func configureTitleForSubbredList(of breed: Breed) {
    self.navigationItem.title = breed.name
  }
  
  func showSelectFlowScreen(includeSubbreedsSetting: Bool) {
    let selectFlowViewController = TypesFlowSelectionViewController()
    selectFlowViewController.output = self
    selectFlowViewController.configureTransitioningDelegate()
    selectFlowViewController.fulfillViewInitializing()
    selectFlowViewController.configureViewState(includeSubbreedsSetting: includeSubbreedsSetting)
    present(selectFlowViewController, animated: true, completion: nil)
  }
  
  func removeTypesFlowSelectionView() {
    dismiss(animated: true, completion: nil)
  }

}

// MARK: - ASTableDelegate
extension DoggoTypeListViewController: ASTableDelegate {
  
  func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    if let doggoTypeIndex = doggosTypes.indices.first(where: { $0 == indexPath.row }) {
      let doggoType = doggosTypes[doggoTypeIndex]
      output.didTapCell(with: doggoType)
    } else {
      displayErrorMessage(nil)
    }
  }
  
}

// MARK: - ASTableDataSource
extension DoggoTypeListViewController: ASTableDataSource {
  
  func numberOfSections(in tableNode: ASTableNode) -> Int {
    return 1
  }
  
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    return doggosTypes.count
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    var cellCreateBlock: ASCellNodeBlock = {
      return ASCellNode()
    }
    
    if let doggoTypeIndex = doggosTypes.indices.first(where: { $0 == indexPath.row }) {
      let doggosType = doggosTypes[doggoTypeIndex]
      cellCreateBlock = {
        let cell = DoggoTypeNode(with: doggosType,
                                 useGradient: indexPath.row % 2 == 0)
        return cell
      }
    }
    return cellCreateBlock
  }
}

// MARK: - Type
extension DoggoTypeListViewController: TypesFlowSelectionViewOutput {
  
  func didSelectIncludeSubbreeds() {
    output.didChoseToIncludeSubbreeds()
  }
  
  func didSelectExcludeSubbreeds() {
    output.didChoseToExcludeSubbreeds()
  }
  
  func didTapCloseButton() {
    output.didTapCloseTypesFlowSelectionView()
  }
  
}
