//
//  MBSwizzler.swift
//  SwizzlingExample
//
//  Created by Max Bazaliy on 6/5/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

import Foundation

extension NSObject {

	class func swizzleMethodSelector(_ origSelector: String, withSelector: String, forClass: AnyClass!) -> Bool {

		var originalMethod: Method?
		var swizzledMethod: Method?

		originalMethod = class_getInstanceMethod(forClass, Selector(origSelector))
		swizzledMethod = class_getInstanceMethod(forClass, Selector(withSelector))

		if (originalMethod != nil && swizzledMethod != nil) {
			method_exchangeImplementations(originalMethod!, swizzledMethod!)
			return true
		}
		return false
	}

	class func swizzleStaticMethodSelector(_ origSelector: String, withSelector: String, forClass: AnyClass!) -> Bool {

		var originalMethod: Method?
		var swizzledMethod: Method?

		originalMethod = class_getClassMethod(forClass, Selector(origSelector))
		swizzledMethod = class_getClassMethod(forClass, Selector(withSelector))

		if (originalMethod != nil && swizzledMethod != nil) {
			method_exchangeImplementations(originalMethod!, swizzledMethod!)
			return true
		}
		return false
	}
}
