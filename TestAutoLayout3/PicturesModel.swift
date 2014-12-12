//
//  PicturesModel.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 11.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit
import CoreData

private let _sharedInstance = PicturesModel()

class PicturesModel: NSObject {
	let photoSize:CGFloat = 43.0
	let bigPhotoSize:CGFloat = 86.0
	
	var fetchedResultsController: NSFetchedResultsController?
	var editPicture:Picture?
	
	typealias OnUpdate = (data:[AnyObject]) -> ()
	var onUpdate : OnUpdate?
	
	class var sharedInstance : PicturesModel {
		return _sharedInstance
	}
	
	func selectData( predicate: NSPredicate) {
		let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
		let managedObjectContext = appDelegate.managedObjectContext!
		
		let entity = NSEntityDescription.entityForName("Picture", inManagedObjectContext: managedObjectContext)
		let sort = NSSortDescriptor(key: "date", ascending: true)
		let fetchRequest = NSFetchRequest()
		fetchRequest.entity = entity
		fetchRequest.sortDescriptors = [sort]
//		fetchRequest.predicate = predicate
		
		let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		aFetchedResultsController.delegate = self
		
		fetchedResultsController = aFetchedResultsController
		
		var e: NSError?
		if !fetchedResultsController!.performFetch(&e) {
			println("fetch error: \(e!.localizedDescription)")
			abort();
		}
		onUpdate!( data: data()!)
	}
	
	func insert(image:UIImage) {
		let managedObjectContext = context()
		let picture = NSEntityDescription.insertNewObjectForEntityForName("Picture", inManagedObjectContext: managedObjectContext) as Picture
		picture.date = NSDate()
		picture.name = "123"
		picture.pic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image, size:CGSizeMake( photoSize, photoSize)))
		picture.bigPic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image, size:CGSizeMake( bigPhotoSize, bigPhotoSize)))
		save()
	}
	
	func edit(image:UIImage?, name:NSString) {
		editPicture?.name = name
		if image != nil {
			editPicture?.pic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image!, size:CGSizeMake( photoSize, photoSize)))
			editPicture?.bigPic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image!, size:CGSizeMake( bigPhotoSize, bigPhotoSize)))
		}
		save()
	}
	
	func context() -> NSManagedObjectContext! {
		return fetchedResultsController?.managedObjectContext
	}
	
	func save() {
		let managedObjectContext = context()
		var e: NSError?
		if !managedObjectContext.save(&e) {
			println("finish error: \(e!.localizedDescription)")
			abort()
		}
	}
	
	func data() -> [AnyObject]? {
		return fetchedResultsController?.fetchedObjects
	}
	
	class func imageWithImage(image:UIImage, size:CGSize) -> (UIImage) {
		var scale = max(size.width/image.size.width, size.height/image.size.height);
		var width = image.size.width * scale;
		var height = image.size.height * scale;
		var imageRect = CGRectMake((size.width - width)/2.0, (size.height - height)/2.0, width, height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		image.drawInRect(imageRect)
		var newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return newImage;
	}
}

extension PicturesModel: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent( controller:NSFetchedResultsController) {
		onUpdate!( data: data()!)
	}
}
