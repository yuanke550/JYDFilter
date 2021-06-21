 
 //
//  JYDFilter.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/4/15.
//

import Foundation

/*
//  筛选器
//  items:组集合
//  configuration:缓存原始数据
//  complate:结果回调
*/
protocol JYDFilterable: AnyObject {
	
	var items: [JYDFilterSectionable] { get set }
	
	var configuration: JYDFilterConfiguration? { get set }
	
	var complate: ((_ result: JYDFilterResult) -> Void) { get }
	
}

/*
//  mapToConfiguration:将操作结果映射给原始数据
//  mapToItems:将原始数据映射给操作项
*/
extension JYDFilterable {
	
	func mapToConfiguration() {
		configuration?.items = items.compactMap({($0.copy() as! JYDFilterSectionable)})
	}
	
	func mapToItems() {
		items = configuration?.items.compactMap({($0.copy() as! JYDFilterSectionable)}) ?? []
	}
	
	func filter() -> JYDFilterResult {
		var result = JYDFilterResult()
		
		for section in items {
			let sectionRet = section.filter()
			result.sections.append(sectionRet)
			result.map[section.identifier] = sectionRet
		}
		
		return result
	}
	
	func resetAll() {
		for section in items {
			section.resetAll()
		}
	}
	
}

public struct JYDFilterConfiguration {
	
	var items: [JYDFilterSectionable] = []
	
}

public class JYDFilter: JYDFilterable {
	
	var complate: (JYDFilterResult) -> Void
	
	var items: [JYDFilterSectionable] = []
	
	var configuration: JYDFilterConfiguration? {
		didSet {
			mapToItems()
		}
	}
	
	init(complate: @escaping (JYDFilterResult) -> Void) {
		self.complate = complate
	}
	
	private lazy var filterView: JYDFilterView = {
		let view = JYDFilterView()
		view.delegate = self
		return view
	}()
	
	public func show() {
		mapToItems()
		filterView.update(items)
		filterView.show()
	}
	
}

extension JYDFilter: JYDFilterViewable {
	
	/// 对筛选项进行了操作
	func opreated() {
		filterView.update(items)
	}
	
	/// 点击了确定按钮
	func certain() {
		mapToConfiguration()
		let result = filter()
		complate(result)
	}
	
	/// 点击了重置按钮
	func reset() {
		resetAll()
		filterView.update(items)
	}
	
}
