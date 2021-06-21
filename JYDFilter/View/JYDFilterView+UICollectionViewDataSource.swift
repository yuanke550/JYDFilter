//
//  JYDFilterView+UICollectionViewDataSource.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation
import UIKit

extension JYDFilterView: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return data?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch data?[section].type {
			case .Item:
				return (data?[section] as? JYDFilterItemSectionable)?.items.count ?? 0
			case .Date:
				return 1
			default:
				break
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let section = data?[indexPath.section] as? JYDFilterItemSectionable {
			
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(JYDFilterItemCell.self), for: indexPath) as? JYDFilterItemCell else { return UICollectionViewCell() }
			
			cell.update(section.items[indexPath.item])
			cell.delegate = self
			
			return cell
			
		} else if let section = data?[indexPath.section] as? JYDFilterDateSectionable {
			
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(JYDFilterDateCell.self), for: indexPath) as? JYDFilterDateCell else { return UICollectionViewCell() }
			
			cell.update(section)
			
			return cell
			
		}
		
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard kind == UICollectionView.elementKindSectionHeader else {
			return UICollectionReusableView()
		}
		guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(JYDFilterCollectionHeader.self), for: indexPath) as? JYDFilterCollectionHeader else {
			return UICollectionReusableView()
		}
		header.title = data?[indexPath.section].name
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.size.width, height: 64)
	}
	
}
