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
	typealias OnUpdate = (data:[Picture]) -> ()

//	let photoSize:CGFloat = 43.0
//	let bigPhotoSize:CGFloat = 86.0
	
	var editPicture:Picture?
	var onUpdate : OnUpdate?
	
	private var fetchedResultsController: NSFetchedResultsController?
	
	class var sharedInstance : PicturesModel {
		return _sharedInstance
	}
	
	class var photoSize:CGFloat {
		return 43.0
	}
	
	class var bigPhotoSize:CGFloat {
		return 86.0
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
	
	func selectData( predicate: NSPredicate?) {
		let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
		let managedObjectContext = appDelegate.managedObjectContext!
		
		let entity = NSEntityDescription.entityForName( NSStringFromClass(Picture), inManagedObjectContext: managedObjectContext)
		let sort = NSSortDescriptor(key: "date", ascending: true)
		let fetchRequest = NSFetchRequest()
		fetchRequest.entity = entity
		fetchRequest.sortDescriptors = [sort]
		if predicate != nil {
			fetchRequest.predicate = predicate
		}
		let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		aFetchedResultsController.delegate = self
		
		fetchedResultsController = aFetchedResultsController
		
		var e: NSError?
		if !fetchedResultsController!.performFetch(&e) {
			println("fetch error: \(e!.localizedDescription)")
			abort();
		}
		onUpdate!( data: data())
	}
	
	func insert(image:UIImage) {
		let managedObjectContext = context()
		let picture = NSEntityDescription.insertNewObjectForEntityForName( NSStringFromClass(Picture), inManagedObjectContext: managedObjectContext) as Picture
		picture.date = NSDate()
		picture.name = ""
		let photoSize = PicturesModel.photoSize
		picture.pic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image, size:CGSizeMake( photoSize, photoSize)))
		let bigPhotoSize = PicturesModel.bigPhotoSize
		picture.bigPic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image, size:CGSizeMake( bigPhotoSize, bigPhotoSize)))
		let uuid = NSUUID().UUIDString
		picture.picFileName = uuid
		photoToFile(image, fileName:uuid)
		save()
	}
	
	func edit(image:UIImage?, name:NSString) {
		editPicture?.name = name
		if image != nil {
			let photoSize = PicturesModel.photoSize
			editPicture?.pic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image!, size:CGSizeMake( photoSize, photoSize)))
			let bigPhotoSize = PicturesModel.bigPhotoSize
			editPicture?.bigPic = UIImagePNGRepresentation( PicturesModel.imageWithImage(image!, size:CGSizeMake( bigPhotoSize, bigPhotoSize)))
			let fileName = editPicture?.picFileName
			if(fileName != nil) {
				photoToFile(image!, fileName:fileName!)
			}
		}
		save()
	}
	
	func deletePicture(picture:Picture) {
		let fileName = picture.picFileName
		deletePhoto(fileName)
		let managedObjectContext = context()
		managedObjectContext.deleteObject(picture)
		save()
	}
	
	func bigPicture() -> UIImage?{
		let fileName = editPicture?.picFileName
		return pfotoFromFile(fileName!)
	}

	private func context() -> NSManagedObjectContext! {
		return fetchedResultsController?.managedObjectContext
	}
	
	private func save() {
		let managedObjectContext = context()
		var e: NSError?
		if !managedObjectContext.save(&e) {
			println("finish error: \(e!.localizedDescription)")
			abort()
		}
	}
	
	private func data() -> [Picture] {
		return fetchedResultsController?.fetchedObjects as [Picture]
	}
	
	private func photoPath(name:NSString) -> NSString {
		let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		let destinationPath = documentsPath.stringByAppendingPathComponent("\(name).jpg")
		return destinationPath
	}
	
	private func photoToFile(image:UIImage, fileName:NSString) {
		let destinationPath = photoPath(fileName)
		UIImageJPEGRepresentation(image,1.0).writeToFile(destinationPath, atomically: true)
	}
	
	private func pfotoFromFile(fileName:NSString) -> UIImage? {
		let destinationPath = photoPath(fileName)
		let image = UIImage(contentsOfFile: destinationPath)
		return image
	}
	
	private func deletePhoto(fileName:NSString) {
		let destinationPath = photoPath(fileName)
		var e:NSError?
		var ok:Bool = NSFileManager.defaultManager().removeItemAtPath(destinationPath, error: &e)
		if e != nil {
			println("Delete error: \(e!.localizedDescription)")
		}
	}
}

extension PicturesModel: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent( controller:NSFetchedResultsController) {
		onUpdate!( data: data())
	}
}
