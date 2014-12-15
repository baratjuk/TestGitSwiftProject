//
//  TableViewController.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 11.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
	@IBOutlet weak var tableView: TableView!
	
	override init() {
		picturesModel = PicturesModel.sharedInstance
		super.init()
	}

	required init(coder aDecoder: NSCoder) {
		picturesModel = PicturesModel.sharedInstance
		super.init(coder: aDecoder)
	}
	
	var picturesModel:PicturesModel
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
		tableView.onAction = {(parameters:TableActions) -> () in
			switch(parameters.type) {
			case TableActions.ActionType.Add:
				let vc = UIImagePickerController()
				if(false) {
					vc.sourceType = UIImagePickerControllerSourceType.Camera;
				}
				vc.delegate = self
				self.presentViewController(vc, animated: true, completion: nil)
			case TableActions.ActionType.Delete:
				self.picturesModel.deletePicture(parameters.picture!)
			case TableActions.ActionType.Picture:
				let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as DetailsViewController
				self.picturesModel.editPicture = parameters.picture
				self.presentViewController(vc, animated: true, completion: nil)
			}
		}
		picturesModel.onUpdate = {(data:[Picture]) -> () in
			self.tableView.data(data)
		}
		picturesModel.selectData( nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		
    }
}

extension TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		picturesModel.insert(image)
		dismissViewControllerAnimated(true, completion:nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion:nil)
	}
}
