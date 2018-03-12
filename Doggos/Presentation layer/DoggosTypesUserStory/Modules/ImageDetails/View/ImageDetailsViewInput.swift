//
//  ImageDetailsImageDetailsViewInput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//
import UIKit

protocol ImageDetailsViewInput: class {

    /**
        @author Alexander_Stepanishin
        Setup initial state of the view
    */

    func setupInitialState()
    func configure(with image: UIImage)
}
