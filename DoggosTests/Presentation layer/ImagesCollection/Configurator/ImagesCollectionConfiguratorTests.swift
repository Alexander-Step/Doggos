//
//  ImagesCollectionImagesCollectionConfiguratorTests.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import XCTest
@testable import Doggos

class ImagesCollectionModuleConfiguratorTests: XCTestCase {

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
        let viewController = ImagesCollectionViewControllerMock()
        let configurator = ImagesCollectionModuleConfigurator()
        let uplineBreed = BreedStorage(name: "Hound", subbreeds: nil, images: nil) as Breed

        //when
      configurator.configureModuleForViewInput(viewInput: viewController, breed: uplineBreed)

        //then
        XCTAssertNotNil(viewController.output, "ImagesCollectionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ImagesCollectionPresenter, "output is not ImagesCollectionPresenter")

        let presenter: ImagesCollectionPresenter = viewController.output as! ImagesCollectionPresenter
        XCTAssertNotNil(presenter.view, "view in ImagesCollectionPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ImagesCollectionPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ImagesCollectionRouter, "router is not ImagesCollectionRouter")

        let interactor: ImagesCollectionInteractor = presenter.interactor as! ImagesCollectionInteractor
        XCTAssertNotNil(interactor.output, "output in ImagesCollectionInteractor is nil after configuration")
    }

    class ImagesCollectionViewControllerMock: ImagesCollectionViewController {
    }
}
