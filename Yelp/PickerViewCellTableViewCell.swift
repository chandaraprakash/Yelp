//
//  PickerViewCellTableViewCell.swift
//  Yelp
//
//  Created by Kumar, Chandaraprakash on 9/23/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

protocol PickerViewCellDelegate {
    func sortValue(message: String)
}

class PickerViewCellTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var pickerViewFilter: UIPickerView!
    
    
    var delegate: PickerViewCellDelegate
    var keys = ["best match", "distance", "highest rated"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(keys[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate.sortValue(keys[row])
    }

}
