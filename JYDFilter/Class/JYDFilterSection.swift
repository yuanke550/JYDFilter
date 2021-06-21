//
//  JYDFilterSection.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation

/*
/// 单选|多选
*/
public enum JYDFilterSelectMode {
	case Radio
	case CheckBox
}

/*
/// 筛选组类型
/// Item:筛选项
/// Date:开始时间&结束时间
*/
public enum JYDFilterSectionType {
	case Item
	case Date
}

/*
/// 筛选组
*/
protocol JYDFilterSectionable: NSCopying {
	
	/// 组标识符
	var identifier: String { get set }
	
	/// 组名
	var name: String { get set }
	
	/// 组类型
	var type: JYDFilterSectionType { get }
	
	/// 组重置
	func resetAll()
	
	/// 组内生产筛选结果
	func filter() -> JYDFilterResultSection
	
}

/// 项类型组
protocol JYDFilterItemSectionable: JYDFilterSectionable {
	
	/// 选择模式
	var mode: JYDFilterSelectMode { get set }
	
	/// 选择项集合
	var items: [JYDFilterItemable] { get set }
	
}

/// 时间类型组
protocol JYDFilterDateSectionable: JYDFilterSectionable {
	
	/// 开始时间标识
	var startDateIdentifier: String { get set }
	
	/// 开始时间值
	var startDate: Date? { get set }
	
	/// 结束时间标识
	var endDateIdentifier: String { get set }
	
	/// 结束时间值
	var endDate: Date? { get set }
	
	/// 时间格式化器
	var dateFormatter: DateFormatter { get set }
	
	/// 最小时间
	var minimumDate: Date { get set }
	
	/// 最大时间
	var maximumDate: Date { get set }
}

public class JYDFilterItemSection: JYDFilterItemSectionable {
	
	public required init() {}
	
	var identifier: String = ""
	
	var name: String = ""
	
	var type: JYDFilterSectionType {
		return .Item
	}
	
	var mode: JYDFilterSelectMode = .CheckBox
	
	var items: [JYDFilterItemable] = []
	
	public func copy(with zone: NSZone? = nil) -> Any {
		let copy = Swift.type(of: self).init()
		copy.identifier = self.identifier
		copy.name = self.name
		copy.mode = self.mode
		copy.items = self.items.compactMap({($0.copy() as! JYDFilterItemable)})
		return copy
	}
	
	func resetAll() {
		for item in items {
			item.selected = false
		}
	}
	
	func filter() -> JYDFilterResultSection {
		var result = JYDFilterResultSection()
		result.identifier = identifier
		result.items = self.items.filter({$0.selected}).compactMap({$0.toResult()})
		return result
	}
	
}

public enum JYDFilterDateIdentifier: String {
	case start = "start"
	case end = "end"
}

class JYDFilterDateSection: JYDFilterDateSectionable {
	
	public required init() {}
	
	var identifier: String = ""
	
	var name: String = ""
	
	var type: JYDFilterSectionType {
		return .Date
	}
	
	var startDateIdentifier: String = JYDFilterDateIdentifier.start.rawValue
	
	var startDate: Date?
	
	var endDateIdentifier: String = JYDFilterDateIdentifier.end.rawValue
	
	var endDate: Date?
	
	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy年M月d日"
		return formatter
	}()
	
	var minimumDate: Date = Date(timeIntervalSince1970: 0)
	
	var maximumDate: Date = Date()
	
	func copy(with zone: NSZone? = nil) -> Any {
		let copy = Swift.type(of: self).init()
		copy.identifier = self.identifier
		copy.name = self.name
		copy.startDateIdentifier = self.startDateIdentifier
		copy.startDate = self.startDate
		copy.endDateIdentifier = self.endDateIdentifier
		copy.endDate = self.endDate
		return copy
	}
	
	func resetAll() {
		startDate = nil
		endDate = nil
	}
	
	func filter() -> JYDFilterResultSection {
		var result = JYDFilterResultSection()
		result.identifier = identifier
		if let value = startDate {
			var startDateRet = JYDFilterResultItem(value: value)
			startDateRet.identifier = startDateIdentifier
			result.items.append(startDateRet)
		}
		if let value = endDate {
			var endDateRet = JYDFilterResultItem(value: value)
			endDateRet.identifier = endDateIdentifier
			result.items.append(endDateRet)
		}
		return result
	}
	
}
