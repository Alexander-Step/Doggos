//
//  BreedListBreedListViewOutput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

protocol DoggoTypeListViewOutput {

  /**
      @author Alexander_Stepanishin
      Notify presenter that view is ready
  */

  func viewIsReady()
  func didTapCell(with doggoType: DoggoType)
  func didTapOpenSelectFlowScreen()
  func didChoseToIncludeSubbreeds()
  func didChoseToExcludeSubbreeds()
  func didTapCloseTypesFlowSelectionView()
}
