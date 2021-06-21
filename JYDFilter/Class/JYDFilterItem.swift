//
//  JYDFilterItem.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation

/*
/// 筛选项
*/
protocol JYDFilterItemable: NSCopying {
	
	/// 项标识符
	var identifier: String { get set }
	
	/// 项名
	var name: String { get set }
	
	/// 项值
	var value: Any { get set }
	
	/// 项选择状态
	var selected: Bool { get set }
	
}

/*
/// toResult:项结果的生产
/// operated:对项发生了操作
*/
extension JYDFilterItemable {
	
	func toResult() -> JYDFilterResultItem {
		var result = JYDFilterResultItem(value: value)
		result.identifier = identifier
		return result
	}
	
	func operated() {
		self.selected = !self.selected
	}
	
}

public class JYDFilterItem: JYDFilterItemable {
	
	var identifier: String = ""
	
	var name: String = ""
	
	var value: Any = 0
	
	var selected: Bool = false
	
	public required init() {}
	
}

extension JYDFilterItem {
	
	public func copy(with zone: NSZone? = nil) -> Any {
		let copy = type(of: self).init()
		copy.identifier = self.identifier
		copy.name = self.name
		copy.value = self.value
		copy.selected = self.selected
		return copy
	}
	
}
