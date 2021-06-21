//
//  DateExtension.swift
//  YKFilter
//
//  Created by 袁科 on 2021/6/21.
//

import Foundation

extension Date {
	/// 获取某天的00:00:00
	/// - Returns: 时间
	public func dayBegin() -> Date {
		let calendar = Calendar(identifier: .gregorian)
		return calendar.startOfDay(for: self)
	}
	
	/// 获取某天的23:59:59
	/// - Returns: 时间
	public func dayEnd() -> Date {
		let begin = self.dayBegin()
		let timestamp = begin.timeIntervalSince1970 + 24 * 60 * 60 - 1
		return Date(timeIntervalSince1970: timestamp)
	}
}
