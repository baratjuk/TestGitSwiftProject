//
//  LoadPictureViewController.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 18.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class LoadPictureViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let url = LoadPictureModel.url
        imageView.setImageWithURL(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
