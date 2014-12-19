//
//  DetailsViewController.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 12.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
	
	@IBOutlet weak var pictureButton: UIButton!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var imageView: RoundCornerImageView!

	
	var originalPicture: UIImage?
	var buttonPicture: UIImage?
	
	var picturesModel:PicturesModel?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		picturesModel = PicturesModel.sharedInstance
		originalPicture = picturesModel?.bigPicture()
		let picture = picturesModel?.editPicture
		textField.text = picture?.name
		buttonPicture = UIImage(data: picture?.bigPic as NSData)!
		textField.delegate = self
		
//		imageView.clipsToBounds = true;
//		imageView.layer.cornerRadius = 20.0
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		pictureButton.clipsToBounds = true;
		pictureButton.layer.cornerRadius = self.pictureButton.bounds.size.height / 2.0
		pictureButton.setBackgroundImage( buttonPicture, forState: UIControlState.Normal)
		imageView.image = originalPicture
		imageView.roundCorners( UIRectCorner.BottomLeft | UIRectCorner.BottomRight, radius: 20.0)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func onChangePhoto(sender: AnyObject) {
		let vc = UIImagePickerController()
		if(false) {
			vc.sourceType = UIImagePickerControllerSourceType.Camera;
		}
		vc.delegate = self
		self.presentViewController(vc, animated: true, completion: nil)
	}
	
	@IBAction func onSave(sender: AnyObject) {
		picturesModel?.edit(originalPicture, name: textField.text)
		dismissViewControllerAnimated(true, completion:nil)
	}
}

extension DetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		originalPicture = image
		let size = PicturesModel.bigPhotoSize
		buttonPicture = PicturesModel.imageWithImage(image, size: CGSizeMake( size, size))
		dismissViewControllerAnimated(true, completion:nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion:nil)
	}
}
extension DetailsViewController:UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		textField.resignFirstResponder()
		return true;
	}
}
