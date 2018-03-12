//
//  BreedListBreedListConfiguratorTests.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import XCTest
@testable import Doggos

class BreedListModuleConfiguratorTests: XCTestCase {

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
        let viewController = DoggoTypeListViewControllerMock()
        let configurator = BreedListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "DoggoTypeListViewController in BreedListModule is nil after configuration")
        XCTAssertTrue(viewController.output is BreedListPresenter, "output is not BreedListPresenter")

        let presenter: BreedListPresenter = viewController.output as! BreedListPresenter
        XCTAssertNotNil(presenter.view, "view in BreedListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in BreedListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is BreedListRouter, "router is not BreedListRouter")
        XCTAssertNotNil(presenter.interactor, "interactor in BreedListPresenter is nil after configuration")
        XCTAssertTrue(presenter.interactor is BreedListInteractor, "interactor is not BreedListInteractor")

        let interactor: BreedListInteractor = presenter.interactor as! BreedListInteractor
        XCTAssertNotNil(interactor.output, "output in BreedListInteractor is nil after configuration")
    }

    class DoggoTypeListViewControllerMock: DoggoTypeListViewController {
    }
}
