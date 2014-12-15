//
//  TableView.swift
//  TestAutoLayout3
//
//  Created by mobidevM199 on 11.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

import UIKit

class TableView: UITableView {
	
	var onAction : TableActions.OnAction?
	
	private var mData = []
	
	override func awakeFromNib() {
		delegate = self
		dataSource = self
	}
	
	func data(data: [AnyObject]) {
		mData = data
		reloadData()
	}
}

extension TableView: UITableViewDataSource {
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mData.count + 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if(indexPath.row == mData.count) {
			let cell = tableView.dequeueReusableCellWithIdentifier("AddTableViewCell") as AddTableViewCell
			cell.onAction = {parameters in
				self.onAction!( parameters: parameters)
			}
			return cell
		}
		var picture = mData[indexPath.row] as Picture
		let cell = tableView.dequeueReusableCellWithIdentifier("LabelTableViewCell") as LabelTableViewCell
		cell.data( picture)
		cell.onAction = {parameters in
			self.onAction!( parameters: parameters)
		}
		return cell
	}
}

extension TableView: UITableViewDelegate {
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		var picture = mData[indexPath.row] as Picture
		self.onAction!( parameters: TableActions( type:TableActions.ActionType.Delete, picture:picture))
	}
}