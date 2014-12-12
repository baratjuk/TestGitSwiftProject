//
//  ViewController.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 10.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var view1: UIView!
	@IBOutlet weak var view2: UIView!
	@IBOutlet weak var view3: UIView!
	@IBOutlet weak var view1_1: UIView!
	@IBOutlet weak var textView: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view1.layer.cornerRadius = 30.0
		view3.layer.cornerRadius = 30.0
		view1_1.layer.cornerRadius = 50.0
		shadow(view1)
		shadow(view2)
		shadow(view3)
		shadow(view1_1)
		textView.delegate = self
//		textView.becomeFirstResponder()
		
		let swipeSelector:Selector = "swipe:"
		let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: swipeSelector)
		swipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
		view1.addGestureRecognizer(swipeRecognizer)
		
		let tapSelector:Selector = "tap:"
		let tapRecognizer = UITapGestureRecognizer(target: self, action: tapSelector)
		tapRecognizer.numberOfTapsRequired = 1
		view2.addGestureRecognizer(tapRecognizer)
		
		let rotationSelector:Selector = "rotation:"
		let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: rotationSelector)
		view2.addGestureRecognizer(rotationRecognizer)
		
		let scaleSelector:Selector = "scale:"
		let scaleRecognizer = UIPinchGestureRecognizer(target: self, action: scaleSelector)
		view1_1.addGestureRecognizer(scaleRecognizer)
		
		let tapSel:Selector = "newVC:"
		let tapRec = UITapGestureRecognizer(target: self, action: tapSel)
		tapRec.numberOfTapsRequired = 1
		view3.addGestureRecognizer(tapRec)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func swipe(sender:AnyObject) {
		println("SWIPE")
		let color = view1.backgroundColor
		view1.backgroundColor = view2.backgroundColor
		view2.backgroundColor = color
	}
	
	func tap(sender:AnyObject) {
		println("TAP")
		let color = view2.backgroundColor
		view2.backgroundColor = view3.backgroundColor
		view3.backgroundColor = color
		
		UIView.animateWithDuration( 0.5, animations: {
			self.view3.transform = CGAffineTransformScale(self.view3.transform,0.5, 0.5)
			}, completion: {
				finished in
				if(finished) {
					UIView.animateWithDuration( 0.5, animations: {
						self.view3.transform = CGAffineTransformScale(self.view3.transform,2.0, 2.0)
					})
				}
			})
	}
	
	func rotation(recognizer : UIRotationGestureRecognizer) {
		println("rotation")
		recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
		recognizer.rotation = 0
	}
	
	func scale(recognizer : UIPinchGestureRecognizer) {
		println("rotation")
		recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform,
			recognizer.scale, recognizer.scale)
		recognizer.scale = 1
	}
	
	func shadow(view:UIView) {
		view.layer.shadowColor = UIColor.blackColor().CGColor
		view.layer.shadowOpacity = 0.8
		view.layer.shadowRadius = 3.0
		view.layer.shadowOffset = CGSizeMake(2.0, 2.0)
	}
	
	func newVC(recognizer : UITapGestureRecognizer) {
		let vc = storyboard?.instantiateViewControllerWithIdentifier("TableViewController") as UIViewController
		self.presentViewController(vc, animated: true, completion: nil)
	}
}

extension ViewController:UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		textField.resignFirstResponder()
		return true;
	}
}

