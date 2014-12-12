//
//  TableViewCells.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 11.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

	@IBOutlet weak var pictureButton: UIButton!
	@IBOutlet weak var label: UILabel!
	
	typealias OnAction = (parameters:AnyObject?) -> ()
	
	var onAction : OnAction?
	var picture: Picture?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		pictureButton.clipsToBounds = true;
		pictureButton.layer.cornerRadius = self.pictureButton.bounds.size.height / 2.0;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func data( picture:Picture) {
		self.picture = picture
		label.text = picture.name
		let pic = UIImage(data: picture.pic as NSData)!
		pictureButton.setBackgroundImage( pic, forState: UIControlState.Normal)
	}
	
	@IBAction func onPicture(sender: AnyObject) {
		onAction!( parameters:self)
	}

}

class AddTableViewCell: UITableViewCell {
	
//	override init() {
//		super.init()
//	}
//
//	required init(coder aDecoder: NSCoder) {
//	    super.init(coder: aDecoder)
//	}
	
	typealias OnAction = (parameters:AnyObject?) -> ()
	
	var onAction : OnAction?
	var picture : Picture?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
	
	@IBAction func onAdd(sender: AnyObject) {
		onAction!( parameters:self)
	}

	
}
