//
//  RoundCornerImageView.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 17.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class RoundCornerImageView: UIImageView {
	func roundCorners(corners:UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii:CGSize(width:radius, height:radius))
		let mask = CAShapeLayer()
		mask.frame = self.bounds
		mask.path = path.CGPath
		self.layer.mask = mask
	}
}
