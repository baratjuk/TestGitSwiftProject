//
//  TableActions.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 15.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class TableActions: NSObject {
	typealias OnAction = (parameters:TableActions) -> ()
	
	enum ActionType {
		case Add
		case Delete
		case Picture
	}
	
	var type:ActionType
	var picture:Picture?
	
	init(type:ActionType, picture:Picture?) {
		self.type = type
		self.picture = picture
	}
	
	class func create()->TableActions {
		return TableActions(type: ActionType.Add, picture: nil)
	}
}
