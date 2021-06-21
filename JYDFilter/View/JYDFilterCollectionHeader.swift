//
//  JYDFilterCollectionHeader.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/4/21.
//

import Foundation
import UIKit
import SnapKit

extension JYDFilterCollectionHeader {
	
	private func setupUI() {
		addSubview(titleLab)
		titleLab.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(24)
			make.left.equalToSuperview()
		}
	}
	
}

class JYDFilterCollectionHeader: UICollectionReusableView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public var title: String? {
		didSet {
			titleLab.text = title
		}
	}
	
	private lazy var titleLab: UILabel = {
		let lab = UILabel()
		lab.text = " "
		lab.font = UIFont.semibold(16)
		lab.textColor = UIColor.colorWith(hex: "#333333")
		return lab
	}()
	
}
