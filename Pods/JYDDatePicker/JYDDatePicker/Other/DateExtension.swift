//
//  DateExtension.swift
//  YKDatePicker
//
//  Created by 袁科 on 2021/6/17.
//

import Foundation

extension Date {
	
	/// 获取指定年以后的日期
	/// - Parameter years: 多少年
	/// - Returns: 日期
	public func afterYears(_ years: Int) -> Date {
		let calendar = Calendar(identifier: .gregorian)
		return calendar.date(byAdding: .year, value: years, to: self)!
	}
	
	/// 获取指定时间的日期
	/// - Returns: 日期
	func day() -> Int {
		let components = NSCalendar.current.dateComponents([.year, .month, .day], from: self)
		return components.day ?? 1
	}
	
	/// 获取指定时间的月份
	/// - Returns: 月份
	func month() -> Int {
		let components = NSCalendar.current.dateComponents([.year, .month, .day], from: self)
		return components.month ?? 1
	}
	
	/// 获取指定时间的年份
	/// - Returns: 年份
	func year() -> Int {
		let components = NSCalendar.current.dateComponents([.year, .month, .day], from: self)
		return components.year ?? 2000
	}
	
}
