//
//  BreedListBreedListViewInput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

protocol DoggoTypeListViewInput: class {

  func configure(with doggoTypes: [DoggoType])
  func showError(_ error: Error?)
  func configureNavigationItemForBreedList()
  func configureTitleForBreedList()
  func configureTitleForSubbredList(of breed: Breed)
  func showSelectFlowScreen(includeSubbreedsSetting: Bool)
  func removeTypesFlowSelectionView()
  
}
