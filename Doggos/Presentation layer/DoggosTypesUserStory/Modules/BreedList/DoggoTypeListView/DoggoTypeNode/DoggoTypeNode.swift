//
//  DogTypeNode.swift
//  Doggos
//
//  Created by Alexander on 3/26/18.
//  Copyright © 2018 None. All rights reserved.
//

import AsyncDisplayKit

class DoggoTypeNode: ASCellNode {
  
  let doggoTypeNodeHeight: CGFloat = 44
  let doggoNameSideInset: CGFloat = 16
  
  private var backgroundImageNode: ASImageNode
  private var nameTextNode: ASTextNode
  
  // MARK: - Lifecycle
  init(with doggoType: DoggoType, useGradient: Bool) {
    backgroundImageNode = ASImageNode()
    if useGradient {
      backgroundImageNode.image = UIImage.doggoTypeCellBackgroundImage()
    } else {
      backgroundImageNode.image = nil
    }
    
    nameTextNode = ASTextNode()
    nameTextNode.placeholderEnabled = true
    nameTextNode.placeholderColor = .lightGray
    nameTextNode.placeholderFadeDuration = 0.15
    nameTextNode.backgroundColor = .clear
    let nameAttributedString = DoggoTypeNode.attributedTitle(from: "\(doggoType.name)")
    nameTextNode.attributedText = nameAttributedString
    nameTextNode.truncationAttributedText = NSAttributedString(string: "...")
    
    super.init()
    clipsToBounds = true
    selectionStyle = .none
    
    addSubnode(backgroundImageNode)
    addSubnode(nameTextNode)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let minConstrainedRatio = doggoTypeNodeHeight/constrainedSize.min.width
    let backgroundImageRatioSpec = ASRatioLayoutSpec(ratio: minConstrainedRatio,
                                                     child: backgroundImageNode)
    
    let nameCenterLayoutSpec = ASCenterLayoutSpec(centeringOptions: .Y,
                                                  sizingOptions: .minimumX,
                                                  child: nameTextNode)
    
    let nameEdgeInsets = UIEdgeInsets(top: 0,
                                      left: doggoNameSideInset,
                                      bottom: 0,
                                      right: doggoNameSideInset)
    
    let nameCenterInsetsSpec = ASInsetLayoutSpec(insets: nameEdgeInsets,
                                           child: nameCenterLayoutSpec)
    
    let nameOverBackgroundOverlaySpec = ASOverlayLayoutSpec(child: backgroundImageRatioSpec,
                                                            overlay: nameCenterInsetsSpec)
    
    return nameOverBackgroundOverlaySpec
  }
  
  // MARK: - Static
  static func attributedTitle(from titleString: String) -> NSAttributedString {
    let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name: "Lato-Bold"])
    let font = UIFont(descriptor: fontDescriptor, size: 16)
    let title = NSAttributedString(string: titleString, attributes: [NSAttributedStringKey.font: font])
    return title
  }
  
}
