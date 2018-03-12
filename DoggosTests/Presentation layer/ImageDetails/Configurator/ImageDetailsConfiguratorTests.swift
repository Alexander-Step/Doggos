//
//  ImageDetailsImageDetailsConfiguratorTests.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import XCTest
@testable import Doggos

class ImageDetailsModuleConfiguratorTests: XCTestCase {

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
        let viewToTransitFromMock = ImageToTransitFromMock()
        let imageMock = UIImage()
        let viewController = ImageDetailsViewControllerMock(viewWithImageToTransitFrom: viewToTransitFromMock)
        let configurator = ImageDetailsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController, image: imageMock)

        //then
        XCTAssertNotNil(viewController.output, "ImageDetailsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ImageDetailsPresenter, "output is not ImageDetailsPresenter")

        let presenter: ImageDetailsPresenter = viewController.output as! ImageDetailsPresenter
        XCTAssertNotNil(presenter.view, "view in ImageDetailsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ImageDetailsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ImageDetailsRouter, "router is not ImageDetailsRouter")
        XCTAssertNotNil(presenter.interactor, "interactor in ImageDetailsPresenter is nil after configuration")
        XCTAssertTrue(presenter.interactor is ImageDetailsInteractor, "interactor is not ImageDetailsInteractor")

        let interactor: ImageDetailsInteractor = presenter.interactor as! ImageDetailsInteractor
        XCTAssertNotNil(interactor.output, "output in ImageDetailsInteractor is nil after configuration")
        XCTAssertTrue(interactor.output is ImageDetailsPresenter, "output in ImageDetailsInteractor is not ImageDetailsPresenter")
      
    }

    class ImageDetailsViewControllerMock: ImageDetailsViewController {
    }
  
    class ImageToTransitFromMock: UIView {
      
    }
}
