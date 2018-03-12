//
//  SubbreedListSubbreedListConfiguratorTests.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import XCTest
@testable import Doggos

class SubbreedListModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

      //given
      let viewController = SubbreedListViewControllerMock()
      let configurator = SubbreedListModuleConfigurator()
      let uplineBreed = BreedStorage(name: "Hound", subbreeds: nil, images: nil) as Breed

      //when
      configurator.configureModuleForViewInput(viewInput: viewController, uplineBreed: uplineBreed)

      //then
      XCTAssertNotNil(viewController.output, "DoggoTypeListViewController in SubbreedListModule is nil after configuration")
      XCTAssertTrue(viewController.output is SubbreedListPresenter, "output is not SubbreedListPresenter")

      let presenter: SubbreedListPresenter = viewController.output as! SubbreedListPresenter
      XCTAssertNotNil(presenter.view, "view in SubbreedListPresenter is nil after configuration")
      XCTAssertNotNil(presenter.router, "router in SubbreedListPresenter is nil after configuration")
      XCTAssertTrue(presenter.router is SubbreedListRouter, "router is not SubbreedListRouter")
      XCTAssertNotNil(presenter.interactor, "interactor in SubbreedListPresenter in nil after configuration")
      XCTAssertTrue(presenter.interactor is SubbreedListInteractor, "interactor is not SubbreedListInteractor")
      
      let interactor: SubbreedListInteractor = presenter.interactor as! SubbreedListInteractor
      XCTAssertNotNil(interactor.output, "output in SubbreedListInteractor is nil after configuration")
    }

    class SubbreedListViewControllerMock: DoggoTypeListViewController {
    }
}
