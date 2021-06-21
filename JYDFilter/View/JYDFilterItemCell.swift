//
//  JYDFilterItemCell.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/4/16.
//

import Foundation
import UIKit

protocol JYDFilterItemCellDelegate: AnyObject {
	func didTap()
}

extension JYDFilterItemCell {
	
	public func update(_ viewModel: JYDFilterItemable) {
		model = viewModel
		nameLab.text = viewModel.name
		nameLab.textColor = viewModel.selected ? UIColor.colorWith(hex: "#1AB77E") : UIColor.colorWith(hex: "#666666")
		bgTap.backgroundColor = viewModel.selected ? UIColor.colorWith(hex: "#E8F7F2") : UIColor.colorWith(hex: "#F8F8F8")
	}
	
}

extension JYDFilterItemCell {
	
	private func setupUI() {
		contentView.addSubview(bgTap)
		bgTap.addSubview(nameLab)
		bgTap.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		nameLab.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(8)
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
			make.bottom.equalToSuperview().offset(-8)
		}
	}
	
	@objc private func tap() {
		self.model?.operated()
		self.delegate?.didTap()
	}
	
}

class JYDFilterItemCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
		setNeedsLayout()
		layoutIfNeeded()
		let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
		var cellFrame = layoutAttributes.frame
		cellFrame.size = size
		layoutAttributes.frame = cellFrame
		return layoutAttributes
	}
	
	public weak var delegate: JYDFilterItemCellDelegate?
	
	private var model: JYDFilterItemable?
	
	private lazy var bgTap: UIButton = {
		let btn = UIButton()
		btn.backgroundColor = UIColor.colorWith(hex: "#F8F8F8")
		btn.layer.cornerRadius = 5
		btn.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
		return btn
	}()
	
	private lazy var nameLab: UILabel = {
		let lab = UILabel()
		lab.text = "-"
		lab.font = UIFont.regular(14)
		lab.textColor = UIColor.colorWith(hex: "#666666")
		lab.textAlignment = .center
		return lab
	}()
	
}
