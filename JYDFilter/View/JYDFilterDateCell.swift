//
//  JYDFilterDateCell.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/8.
//

import Foundation
import UIKit
import JYDDatePicker

extension JYDFilterDateCell {
	
	public func update(_ viewModel: JYDFilterDateSectionable) {
		model = viewModel
		if let startDate = viewModel.startDate {
			let dateStr = viewModel.dateFormatter.string(from: startDate)
			startBtn.setTitle(dateStr, for: UIControl.State())
			startBtn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
		} else {
			startBtn.setTitle("开始时间", for: UIControl.State())
			startBtn.setTitleColor(UIColor.colorWith(hex: "#CCCCCC"), for: UIControl.State())
		}
		
		if let endDate = viewModel.endDate {
			let dateStr = viewModel.dateFormatter.string(from: endDate)
			endBtn.setTitle(dateStr, for: UIControl.State())
			endBtn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
		} else {
			endBtn.setTitle("结束时间", for: UIControl.State())
			endBtn.setTitleColor(UIColor.colorWith(hex: "#CCCCCC"), for: UIControl.State())
		}
	}
	
}

extension JYDFilterDateCell {
	
	private func setupUI() {
		contentView.addSubview(startBtn)
		contentView.addSubview(connectLab)
		contentView.addSubview(endBtn)
		startBtn.snp.makeConstraints { (make) in
			make.top.left.equalToSuperview()
			make.width.equalTo(buttonWidth)
			make.height.equalTo(38)
			make.bottom.equalToSuperview().priority(.high)
		}
		
		connectLab.snp.makeConstraints { (make) in
			make.center.equalToSuperview()
		}
		
		endBtn.snp.makeConstraints { (make) in
			make.top.right.equalToSuperview()
			make.left.equalTo(startBtn.snp.right).offset(35).priority(.high)
			make.width.equalTo(buttonWidth)
			make.height.equalTo(38)
		}
	}
	
	private func updateStartDate(with date: Date) {
		if let endDate = self.model?.endDate, date.compare(endDate) == .orderedDescending {
			fatalError("YKFilter: The start Date must be less than the end date")
		}
		self.model?.startDate = date
		let dateStr = self.model?.dateFormatter.string(from: date)
		self.startBtn.setTitle(dateStr, for: UIControl.State())
		self.startBtn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
	}
	
	private func updateEndDate(with date: Date) {
		if let startDate = self.model?.startDate, startDate.compare(date) == .orderedDescending {
			fatalError("YKFilter: The end Date must be more than the start date")
		}
		self.model?.endDate = date
		let dateStr = self.model?.dateFormatter.string(from: date)
		self.endBtn.setTitle(dateStr, for: UIControl.State())
		self.endBtn.setTitleColor(UIColor.colorWith(hex: "#666666"), for: UIControl.State())
	}
	
	@objc private func clickedStartBtn() {
		self.datePicker.title = "选择开始日期"
		let selectDate = self.model?.dateFormatter.date(from: self.startBtn.title(for: UIControl.State()) ?? "")
		self.datePicker.pick(with: selectDate, { (date) in
			self.updateStartDate(with: date.dayBegin())
		})
	}
	
	@objc private func clickedEndBtn() {
		self.datePicker.title = "选择结束日期"
		let selectDate = self.model?.dateFormatter.date(from: self.endBtn.title(for: UIControl.State()) ?? "")
		self.datePicker.pick(with: selectDate, { (date) in
			self.updateEndDate(with: date.dayEnd())
		})
	}
	
}

class JYDFilterDateCell: UICollectionViewCell {
	
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
	
	private var buttonWidth: CGFloat {
		return (UIScreen.main.bounds.size.width - 20 * 2 - 35) / 2.0
	}
	
	private var model: JYDFilterDateSectionable?
	
	private lazy var datePicker: JYDDatePicker = {
		let picker = JYDDatePicker()
		picker.style = .Date
		return picker
	}()
	
	private lazy var startBtn: UIButton = {
		let btn = UIButton()
		btn.backgroundColor = UIColor.colorWith(hex: "#F8F8F8")
		btn.setTitle("开始时间", for: UIControl.State())
		btn.setTitleColor(UIColor.colorWith(hex: "#CCCCCC"), for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(14)
		btn.layer.cornerRadius = 4
		btn.addTarget(self, action: #selector(self.clickedStartBtn), for: .touchUpInside)
		return btn
	}()
	
	private lazy var connectLab: UILabel = {
		let lab = UILabel()
		lab.text = "至"
		lab.font = UIFont.regular(14)
		lab.textColor = UIColor.colorWith(hex: "#CCCCCC")
		lab.textAlignment = .center
		return lab
	}()
	
	private lazy var endBtn: UIButton = {
		let btn = UIButton()
		btn.backgroundColor = UIColor.colorWith(hex: "#F8F8F8")
		btn.setTitle("结束时间", for: UIControl.State())
		btn.setTitleColor(UIColor.colorWith(hex: "#CCCCCC"), for: UIControl.State())
		btn.titleLabel?.font = UIFont.regular(14)
		btn.layer.cornerRadius = 4
		btn.addTarget(self, action: #selector(self.clickedEndBtn), for: .touchUpInside)
		return btn
	}()
}
