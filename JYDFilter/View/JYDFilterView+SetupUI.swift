//
//  JYDFilterView+SetupUI.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation
import UIKit

extension JYDFilterView {
	
	internal func setupUI() {
		addSubview(bgView)
		addSubview(contentBg)
		contentBg.addSubview(titleLab)
		contentBg.addSubview(closeBtn)
		contentBg.addSubview(lineView)
		contentBg.addSubview(collectView)
		contentBg.addSubview(footerBg)
		footerBg.addSubview(resetBtn)
		footerBg.addSubview(certainBtn)
		
		bgView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		titleLab.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(19)
			make.left.equalToSuperview().offset(20)
		}
		
		closeBtn.snp.makeConstraints { (make) in
			make.right.equalToSuperview().offset(-20)
			make.centerY.equalTo(titleLab)
			make.width.height.equalTo(24)
		}
		
		lineView.snp.makeConstraints { (make) in
			make.top.equalTo(titleLab.snp.bottom).offset(17)
			make.left.right.equalToSuperview()
			make.height.equalTo(0.5)
		}
		
		collectView.snp.makeConstraints { (make) in
			make.top.equalTo(lineView.snp.bottom).offset(5)
			make.left.equalToSuperview().offset(20)
			make.right.equalToSuperview().offset(-20)
			make.bottom.equalTo(footerBg.snp.top)
		}
		
		footerBg.snp.makeConstraints { (make) in
			if #available(iOS 11.0, *) {
				make.bottom.equalToSuperview().offset(-safeBottomInset)
			} else {
				make.bottom.equalToSuperview()
			}
			make.left.right.equalToSuperview()
			make.height.equalTo(58)
		}
		
		resetBtn.snp.makeConstraints { (make) in
			make.centerY.equalToSuperview()
			make.left.equalToSuperview().offset(20)
			make.width.equalTo((UIScreen.main.bounds.size.width - 20 * 2 - 10) / 3)
			make.height.equalTo(44)
		}
		
		certainBtn.snp.makeConstraints { (make) in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().offset(-20)
			make.width.equalTo((UIScreen.main.bounds.size.width - 20 * 2 - 10) / 3 * 2)
			make.height.equalTo(44)
		}
		
	}
	
}
