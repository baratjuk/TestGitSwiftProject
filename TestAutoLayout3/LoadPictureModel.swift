//
//  LoadPictureModel.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 18.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class LoadPictureModel: NSObject {
	class var url:NSURL {
		let urlStr = "https://www.friskies.com/Content/images/headers/cat_wet.png"
		return NSURL(string: urlStr)!
	}
	
	
}
