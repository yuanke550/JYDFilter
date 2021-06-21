//
//  JYDFilterResult.swift
//  JiaYiDoctor
//
//  Created by 袁科 on 2021/5/10.
//

import Foundation

/*
/// ResultItem
/// 筛选结果的最小数据结构
/// identifier:筛选项标识符
/// value:其可能携带的值,如果该类筛选项没有携带值的实际意义,则identifier==value
*/
public struct JYDFilterResultItem {
	
	var identifier: String = ""
	
	var value: Any
	
}

/*
/// ResultSection
/// 筛选结果的二级数据结构
/// identifier:筛选组的标识符
/// items:筛选出的结果集合
*/
public struct JYDFilterResultSection {
	
	var identifier: String = ""
	
	var items: [JYDFilterResultItem] = []
	
}

/*
/// Result
/// 筛选结果的一级数据结构
/// section:筛选组的集合,如果该组没有选择项,则组内的筛选项集合为空
/// map:筛选组的映射表,key为section的identifier,value为section
/// section和map同时存在是为了业务层在使用的时候更灵活,根据后台接口定义的数据结构不同,选择section或map能更方便的映射为接口需要的数据结构
*/
public struct JYDFilterResult {
	
	var sections: [JYDFilterResultSection] = []
	
	var map: [String : JYDFilterResultSection] = [:]
	
}
