//
//  JYDDatePicker.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation

/// 选择器模式
/// Default:默认模式,从1970年1月1日到当前时间
/// Specify:指定模式,指定最小时间和最大时间
/// After:从指定时间到之后的100年
/// Befor:从1970年1月1日到指定时间
public enum JYDDatePickerMode {
	
	case Default
	
	case Specify(Date, Date)
	
	case After(Date)
	
	case Before(Date)
	
}

/// 时间选择器风格
/// Date:年/月/日
/// Time:时/分
/// DateAndTime:月/日 上午|下午 时/分
public enum JYDDatePickerStyle {
	
	case Date
	
	case Time
	
	case DateAndTime
	
}

extension JYDDatePicker {
	
	public func pick(_ complete: @escaping (_ date: Date) -> Void) {
		self.complete = complete
		self.view.show()
	}
	
	public func pick(with selectDate: Date?, _ complete: @escaping (_ date: Date) -> Void) {
		self.complete = complete
		self.view.selectDate = selectDate
		self.view.show()
	}
	
}

public class JYDDatePicker {
	
	public init() {}
	
	public var model: JYDDatePickerMode = .Default {
		didSet {
			switch model {
				case .Default:
					view.minimumDate = Date(timeIntervalSince1970: 0)
					view.maximumDate = Date()
				case .Specify(let min, let max):
					guard min.compare(max) == .orderedDescending else {
						fatalError("JYDDatePicker：The minimum time must be less than the maximum time")
					}
					view.minimumDate = min
					view.maximumDate = max
				case .After(let date):
					view.minimumDate = date
					view.maximumDate = date.afterYears(100)
				case .Before(let date):
					guard date.compare(Date(timeIntervalSince1970: 0)) == .orderedDescending else {
						fatalError("JYDDatePicker：The before time must be more than 1970/1/1 00:00:00")
					}
					view.minimumDate = Date(timeIntervalSince1970: 0)
					view.maximumDate = date
			}
		}
	}
	
	public var style: JYDDatePickerStyle = .DateAndTime {
		didSet {
			switch style {
				case .Date:
					view.pickerMode = .date
				case .Time:
					view.pickerMode = .time
				case .DateAndTime:
					view.pickerMode = .dateAndTime
			}
		}
	}
	
	public var title: String? {
		didSet {
			view.title = title
		}
	}
	
	private lazy var view: JYDDatePickerView = {
		let view = JYDDatePickerView()
		view.delegate = self
		return view
	}()
	
	private var complete: ((_ date: Date) -> Void)?
	
}

extension JYDDatePicker: JYDDatePickerViewDelegate {
	
	public func selected(with date: Date) {
		self.complete?(date)
	}
	
}

protocol JYDDateDataSource {
	
	func component() -> Int
	
	func row() -> Int
	
	func data(with component: Int, _ row: Int) -> String
	
	func didSelect(row: Int, in component: Int)
	
}

struct JYDDateMaridiemDateSource {
	
	public init(minimumDate: Date, maximumDate: Date) {
		guard minimumDate.compare(maximumDate) == .orderedDescending else {
			fatalError("JYDDateMaridiemDateSource: The minimumDate must be less than the maximumDate")
		}
		self.minimumDate = minimumDate
		self.maximumDate = maximumDate
	}
	
	public var minimumDate: Date
	
	public var maximumDate: Date
	
	public var amSymbol: String = "上午"
	
	public var pmSymbol: String = "下午"
	 
	public var years: [Int] = []
	
	public var months: [Int] = []
	
	public var days: [Int] = []
	
	public var maridiem: [String] {
		return [amSymbol, pmSymbol]
	}
	
	public func didSelect(row: Int, in component: Int) {
		switch component {
			case 0:
				let year = years[row]
				if year == minimumDate.year() {
					
				} else if year == maximumDate.year() {
					
				} else {
					
				}
			case 1:
				break
			default:
				break
		}
	}
	
}

extension JYDDateMaridiemDateSource {
	/// 构建原始数据
	private mutating func constructRawData() {
		let miniYear = minimumDate.year()
		let maxiYear = maximumDate.year()
		let miniMonth = minimumDate.month()
		let maxiMonth = maximumDate.month()
		if miniYear == maxiYear && miniMonth == maxiMonth {
			
		}
		if miniYear == maxiYear {
			/// 同年
			self.years = [maxiYear]
			if miniMonth == maxiMonth {
				/// 同月
				self.months = [maxiMonth]
			} else {
				/// 不同月
				self.months = Array(miniMonth...maxiMonth)
			}
		} else {
			/// 不同年
			self.years = Array(miniYear...maxiYear)
			if miniMonth == 12 {
				/// 末月
				self.months = [12]
			} else {
				self.months = Array(miniMonth...12)
			}
		}
	}
	
}
