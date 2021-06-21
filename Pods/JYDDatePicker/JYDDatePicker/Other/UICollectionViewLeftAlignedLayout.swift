//
//  UICollectionViewLeftAlignedLayout.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/4/21.
//

import Foundation
import UIKit

extension UICollectionViewLayoutAttributes {
	/** 每行第一个item左对齐 **/
	func leftAlignFrame(sectionInset: UIEdgeInsets) {
		var frame = self.frame
		frame.origin.x = sectionInset.left
		self.frame = frame
	}
}

class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let attributesToReturn = super.layoutAttributesForElements(in: rect)!
		for attributes in attributesToReturn {
			if attributes.representedElementKind == nil {
				let indexPath = attributes.indexPath
				attributes.frame = self.layoutAttributesForItem(at: indexPath)!.frame
			}
		}
		return attributesToReturn
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)!
		let sectionInset = self.evaluatedSectionInset(itemAtIndex: indexPath.section)
		let isFirstItemInSection = indexPath.item == 0
		let layoutWidth: CGFloat = self.collectionView!.frame.width - sectionInset.left - sectionInset.right
		if isFirstItemInSection {
			currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
			return currentItemAttributes
		}
		let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
		let previousFrame = self.layoutAttributesForItem(at: previousIndexPath)!.frame
		let previousFrameRightPoint: CGFloat = previousFrame.origin.x + previousFrame.size.width
		let currentFrame = currentItemAttributes.frame
		let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
		let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
		if isFirstItemInRow {
			currentItemAttributes.leftAlignFrame(sectionInset: sectionInset)
			return currentItemAttributes
		}
		var frame = currentItemAttributes.frame
		frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacing(ItemAtIndex: indexPath.item)
		currentItemAttributes.frame = frame
		return currentItemAttributes
	}
	
	private func evaluatedMinimumInteritemSpacing(ItemAtIndex: Int) -> CGFloat     {
		if let delete = self.collectionView?.delegate {
			weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
			if delegate!.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))) {
				let mini =  delegate?.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: ItemAtIndex)
				if mini != nil {
					return mini!
				}
			}
		}
		return self.minimumInteritemSpacing
	}
	
	private func evaluatedSectionInset(itemAtIndex: Int) -> UIEdgeInsets {
		if let delete = self.collectionView?.delegate {
			weak var delegate = (delete as! UICollectionViewDelegateFlowLayout)
			if delegate!.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) {
				let sectionInset = delegate?.collectionView?(self.collectionView!, layout: self, insetForSectionAt: itemAtIndex)
				if sectionInset != nil {
					return sectionInset!
				}
			}
			
		}
		return self.sectionInset
	}
}
