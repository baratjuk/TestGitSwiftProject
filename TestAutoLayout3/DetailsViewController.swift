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
	@IBOutlet weak var imageView: UIImageView!
	
	var originalPicture: UIImage?
	
	var picturesModel:PicturesModel?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		picturesModel = PicturesModel.sharedInstance
		let picture = picturesModel?.editPicture
		textField.text = picture?.name
		let pic = UIImage(data: picture?.bigPic as NSData)!
		pictureButton.clipsToBounds = true;
		pictureButton.layer.cornerRadius = self.pictureButton.bounds.size.height / 2.0
		pictureButton.setBackgroundImage( pic, forState: UIControlState.Normal)
		imageView.image = picturesModel?.bigPicture()
		textField.delegate = self
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
		let pic = PicturesModel.imageWithImage(image, size: CGSizeMake( 86.0, 86.0))
		pictureButton.setBackgroundImage( pic, forState: UIControlState.Normal)
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
