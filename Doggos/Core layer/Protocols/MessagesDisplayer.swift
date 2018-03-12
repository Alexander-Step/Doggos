//
//  MessagesDisplayer.swift
//  Doggos
//
//  Created by Alexander on 3/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import SwiftMessages

protocol MessagesDisplayer {
}

extension MessagesDisplayer where Self: UIViewController {
  
  func displayErrorMessage(_ error: Error?) {
    let messageTitle = errorMessageTitle(from: error)
    let messageSubtitle = errorMessageSubtitle(from: error)
    let messageView = bottomMessageViewWithTitleAndSubtitle()
    messageView.configureContent(title: messageTitle, body: messageSubtitle)
    SwiftMessages.show(config: bottomMessagesConfig(), view: messageView)
  }
  
  // MARK: - Private
  // MARK: Message config
  private func errorMessageTitle(from error: Error?) -> String {
    var title = "Something went wrong"
    if let remoteServiceError = error as? RemoteServiceError {
      title = remoteServiceError.rawValue
    } else if let localServiceError = error as? LocalServiceError {
      title = localServiceError.rawValue
    } else if let moduleInternalError = error as? ModuleInternalError {
      switch moduleInternalError {
      case .noSubbreedsFound:
        title = ""
      default:
        title = moduleInternalError.rawValue
      }
    }
    return title
  }
  
  private func errorMessageSubtitle(from error: Error?) -> String {
    var subtitle = "Try again later"
    if (error as? RemoteServiceError) != nil {
      subtitle = ""
    } else if (error as? LocalServiceError) != nil {
      subtitle = ""
    } else if let moduleInternalError = error as? ModuleInternalError {
      switch moduleInternalError {
      case .noSubbreedsFound:
        subtitle = moduleInternalError.rawValue
      default:
        subtitle = ""
      }
    }
    return subtitle
  }
  
  // MARK: Basic view config
  private func bottomMessageViewWithTitleAndSubtitle() -> MessageView {
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureTheme(.info)
    view.configureDropShadow()
    view.tapHandler = { baseView in
      SwiftMessages.hide()
    }
    view.backgroundColor = .clear
    view.backgroundView.backgroundColor = .black
    view.button?.isHidden = true
    view.iconLabel?.isHidden = true
    view.iconImageView?.isHidden = true
    view.titleLabel?.textColor = .white
    let titleFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name: "Lato-bold"])
    view.titleLabel?.font = UIFont(descriptor: titleFontDescriptor, size: 18)
    view.bodyLabel?.textColor = .white
    let subtitleFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name: "Lato"])
    view.bodyLabel?.font = UIFont(descriptor: subtitleFontDescriptor, size: 14)
    return view
  }
  
  func bottomMessagesConfig(statusBarStyle: UIStatusBarStyle = .default) -> SwiftMessages.Config {
    var config = SwiftMessages.defaultConfig
    config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
    config.presentationStyle = .bottom
    config.duration = .seconds(seconds: 3)
    config.interactiveHide = true
    config.preferredStatusBarStyle = statusBarStyle
    return config
  }
  
}
