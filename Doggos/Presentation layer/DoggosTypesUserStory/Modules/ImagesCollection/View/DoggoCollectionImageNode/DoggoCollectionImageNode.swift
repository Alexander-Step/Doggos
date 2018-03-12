//
//  DoggoCollectionImageNode.swift
//  Doggos
//
//  Created by Alexander on 4/6/18.
//  Copyright © 2018 None. All rights reserved.
//

import AsyncDisplayKit

class DoggoCollectionImageNode: ASCellNode {
  
  private var networkImageNode: ASNetworkImageNode
  
  // MARK: - Lifecycle
  init(withLinkContainer linkContainer: ImageLinkContainer) {
    networkImageNode = ASNetworkImageNode.init()
    networkImageNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor()
    networkImageNode.contentMode = .scaleAspectFill
    let imageURL = URL(string: linkContainer.link)
    networkImageNode.url = imageURL
    
    super.init()
    selectionStyle = .none
    
    addSubnode(networkImageNode)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let imageDimension = constrainedSize.max.width
    networkImageNode.style.preferredSize = CGSize(width: imageDimension, height: imageDimension)
    
    let imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let imageInsetsSpec = ASInsetLayoutSpec(insets: imageInsets,
                                            child: networkImageNode)
    return imageInsetsSpec
  }
  
  // MARK: - Internal
  func reportDisplayingView() -> UIView {
    return networkImageNode.view
  }
  
  func reportDisplayingImage() -> UIImage? {
    return networkImageNode.image
  }
  
}

// MARK: - ASNetworkImageNodeDelegate
extension DoggoCollectionImageNode: ASNetworkImageNodeDelegate {

  func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
    setNeedsLayout()
  }

}
