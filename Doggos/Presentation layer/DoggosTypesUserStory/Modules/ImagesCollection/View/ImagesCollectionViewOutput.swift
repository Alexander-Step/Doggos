//
//  ImagesCollectionImagesCollectionViewOutput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

protocol ImagesCollectionViewOutput {

    /**
        @author Alexander_Stepanishin
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didTapCellWith(image: UIImage, viewContainingImage: UIView)
}
