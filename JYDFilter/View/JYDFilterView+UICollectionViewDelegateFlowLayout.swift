//
//  JYDFilterView+UICollectionViewDelegateFlowLayout.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation
import UIKit

extension JYDFilterView: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}
	
}
