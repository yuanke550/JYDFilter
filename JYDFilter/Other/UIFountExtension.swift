//
//  UIFountExtension.swift
//  YKFilter
//
//  Created by 袁科 on 2021/6/16.
//

import Foundation
import UIKit

extension UIFont {
  public static func medium(_ fontSize: CGFloat) -> UIFont? {
	return UIFont(name: "PingFangSC-Medium", size: fontSize);
  }
  
  public static func regular(_ fontSize: CGFloat) -> UIFont! {
	return UIFont(name: "PingFangSC-Regular", size: fontSize);
  }
  
  public static func semibold(_ fontSize: CGFloat = 14) -> UIFont {
	return UIFont(name: "PingFangSC-Semibold", size: fontSize)!;
  }
  
  public static func light(_ fontSize: CGFloat) -> UIFont? {
	return UIFont(name: "PingFangSC-Light", size: fontSize);
  }
}
