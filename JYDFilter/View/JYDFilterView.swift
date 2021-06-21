//
//  JYDFilterView.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/4/15.
//

import Foundation
import UIKit

protocol JYDFilterViewable: AnyObject {
	func certain()
	func reset()
	func opreated()
}

extension JYDFilterView {
	
	public func update(_ items: [JYDFilterSectionable]) {
		data = items
		collectView.reloadData()
	}
	
	public func show() {
		UIApplication.shared.keyWindow?.addSubview(self)
		self.isHidden = false
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let `self` = self else {
				return
			}
			let bounds = self.contentBg.bounds
			self.contentBg.frame = CGRect(x: 0, y: self.bounds.height - bounds.height, width: bounds.width, height: bounds.height)
		}
	}
	
}

extension JYDFilterView {
	
	private func dismiss() {
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let `self` = self else {
				return
			}
			let bounds = self.contentBg.bounds
			self.contentBg.frame = CGRect(x: 0, y: self.bounds.height, width: bounds.width, height: bounds.height)
		} completion: { [weak  self](finish) in
			if finish {
				self?.isHidden = true
				self?.removeFromSuperview()
			}
            self?.removeFromSuperview()
            self = nil
		}

	}
	
	@objc private func clickedCloseBtn() {
		self.dismiss()
	}
	
	@objc private func clickedResetBtn() {
		self.delegate?.reset()
	}
	
	@objc private func clickedCertainBtn() {
		self.delegate?.certain()
		self.dismiss()
	}
	
}

class JYDFilterView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: UIScreen.main.bounds)
		self.isHidden = true
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public weak var delegate: JYDFilterViewable?
	
	internal var data: [JYDFilterSectionable]?
	
	internal var safeBottomInset: CGFloat {
		if #available(iOS 11.0, *) {
			return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
		} else {
			return 0
		}
	}
	
	internal lazy var bgView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.colorWith(hex: "#000000")
		view.alpha = 0.5
		return view
	}()
	
	internal lazy var contentBg: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height * 0.9))
		view.backgroundColor = .white
		return view
	}()
	
	internal lazy var titleLab: UILabel = {
		let lab = UILabel()
		lab.text = "筛选"
		lab.font = UIFont.semibold(18)
		lab.textColor = UIColor.colorWith(hex: "#222222")
		return lab
	}()
	
	internal lazy var closeBtn: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named: "pop_close_ic"), for: UIControl.State())
		btn.addTarget(self, action: #selector(self.clickedCloseBtn), for: .touchUpInside)
		return btn
	}()
	
	internal lazy var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.colorWith(hex: "#F7F7F7")
		return view
	}()
	
	internal lazy var collectView: UICollectionView = {
		let layout = UICollectionViewLeftAlignedLayout()
		layout.scrollDirection = .vertical
		layout.estimatedItemSize = CGSize(width: 88, height: 38)
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.backgroundColor = .white
		view.delegate = self
		view.dataSource = self
		view.register(JYDFilterItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(JYDFilterItemCell.self))
		view.register(JYDFilterDateCell.self, forCellWithReuseIdentifier: NSStringFromClass(JYDFilterDateCell.self))
		view.register(JYDFilterCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(JYDFilterCollectionHeader.self))
		return view
	}()
	
	internal lazy var footerBg: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	internal lazy var resetBtn: UIButton = {
		let btn = UIButton()
		btn.backgroundColor = .white
		btn.setTitle("重置", for: UIControl.State())
		btn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(14)
		btn.layer.cornerRadius = 5
		btn.layer.borderWidth = 1
		btn.layer.borderColor = UIColor.colorWith(hex: "#CCCCCC").cgColor
		btn.addTarget(self, action: #selector(self.clickedResetBtn), for: .touchUpInside)
		return btn
	}()
	
	internal lazy var certainBtn: UIButton = {
		let btn = UIButton()
		btn.backgroundColor = UIColor.colorWith(hex: "#1AB77E")
		btn.setTitle("确认", for: UIControl.State())
		btn.setTitleColor(.white, for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(14)
		btn.layer.cornerRadius = 5
		btn.addTarget(self, action: #selector(self.clickedCertainBtn), for: .touchUpInside)
		return btn
	}()
	
}

extension JYDFilterView: JYDFilterItemCellDelegate {
	
	func didTap() {
		delegate?.opreated()
	}
	
}
