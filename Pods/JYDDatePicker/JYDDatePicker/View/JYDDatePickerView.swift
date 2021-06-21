//
//  JYDDatePickerView.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation
import UIKit
import SnapKit

protocol JYDDatePickerViewDelegate: AnyObject {
	
	func selected(with date: Date)
	
}

extension JYDDatePickerView {
	
	public func show() {
		UIApplication.shared.keyWindow?.addSubview(self)
		self.isHidden = false
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let `self` = self else { return }
			self.alpha = 1.0
			let selfBounds = self.bounds
			let contentBounds = self.contentBg.bounds
			var newFrame = CGRect()
			newFrame.origin.x = 0
			newFrame.origin.y = selfBounds.height - contentBounds.height
			newFrame.size = contentBounds.size
			self.contentBg.frame = newFrame
		}
	}
	
}

extension JYDDatePickerView {
	
	private func setupUI() {
		addSubview(blackBg)
		addSubview(contentBg)
		contentBg.addSubview(cancelBtn)
		contentBg.addSubview(certainBtn)
		contentBg.addSubview(titleLab)
		contentBg.addSubview(lineView)
		contentBg.addSubview(picker)
		
		cancelBtn.snp.makeConstraints { (make) in
			make.top.left.equalToSuperview()
			make.width.height.equalTo(45)
		}
		
		certainBtn.snp.makeConstraints { (make) in
			make.top.right.equalToSuperview()
			make.width.height.equalTo(45)
		}
		
		titleLab.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalTo(cancelBtn.snp.right)
			make.right.equalTo(certainBtn.snp.left)
			make.height.equalTo(45)
		}
		
		lineView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(45)
			make.left.right.equalToSuperview()
			make.height.equalTo(0.5)
		}
		
		picker.snp.makeConstraints { (make) in
			make.top.equalTo(lineView.snp.bottom)
			make.left.right.bottom.equalToSuperview()
		}
	}
	
	private func hide() {
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let `self` = self else { return }
			var newFrame = CGRect()
			newFrame.origin.x = 0
			newFrame.origin.y = self.bounds.height
			newFrame.size = self.contentBg.bounds.size
			self.contentBg.frame = newFrame
		} completion: { [weak self](finished) in
			guard let `self` = self else { return }
			if finished {
				self.isHidden = true
				self.alpha = 0.0
				self.removeFromSuperview()
			}
		}

	}
	
	@objc private func clickedCancelBtn() {
		self.hide()
	}
	
	@objc private func clickedCertainBtn() {
		let date = self.picker.date
		self.delegate?.selected(with: date)
		self.hide()
	}
	
}

class JYDDatePickerView: UIView {
	
	public override init(frame: CGRect) {
		super.init(frame: UIScreen.main.bounds)
		isHidden = true
		alpha = 0.0
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public weak var delegate: JYDDatePickerViewDelegate?
	
	public var title: String? {
		didSet {
			self.titleLab.text = title
		}
	}
	
	public var minimumDate: Date? {
		didSet {
			picker.minimumDate = minimumDate
		}
	}
	
	public var maximumDate: Date? {
		didSet {
			picker.maximumDate = maximumDate
		}
	}
	
	public var pickerMode: UIDatePicker.Mode = .dateAndTime {
		didSet {
			picker.datePickerMode = pickerMode
		}
	}
	
	public var selectDate: Date? {
		didSet {
			if let date = selectDate {
				self.picker.setDate(date, animated: true)
			}
		}
	}
	
	/// 高度为屏幕的2/5
	private var contentHeight: CGFloat = UIScreen.main.bounds.height / 5 * 2
	
	private lazy var blackBg: UIView = {
		let view = UIView(frame: self.bounds)
		view.backgroundColor = .black
		view.alpha = 0.5
		return view
	}()
	
	private lazy var contentBg: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: contentHeight))
		view.backgroundColor = .white
		return view
	}()
	
	private lazy var cancelBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("取消", for: UIControl.State())
		btn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(15)
		btn.addTarget(self, action: #selector(self.clickedCancelBtn), for: .touchUpInside)
		return btn
	}()
	
	private lazy var certainBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("确定", for: UIControl.State())
		btn.setTitleColor(UIColor.colorWith(hex: "#1AB77E"), for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(15)
		btn.addTarget(self, action: #selector(self.clickedCertainBtn), for: .touchUpInside)
		return btn
	}()
	
	private lazy var titleLab: UILabel = {
		let lab = UILabel()
		lab.text = " "
		lab.font = UIFont.semibold(16)
		lab.textColor = UIColor.colorWith(hex: "#333330")
		lab.textAlignment = .center
		return lab
	}()
	
	private lazy var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.colorWith(hex: "#E5E5E5")
		return view
	}()
	
	private lazy var picker: UIDatePicker = {
		let picker = UIDatePicker()
		picker.date = Date()
		picker.minimumDate = Date(timeIntervalSince1970: 0)
		picker.maximumDate = Date()
		picker.datePickerMode = .dateAndTime
		picker.locale = Locale(identifier: "zh_CN")
		if #available(iOS 13.4, *) {
			picker.preferredDatePickerStyle = .wheels
		}
		return picker
	}()
	
}


