//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Kumar, Chandaraprakash on 9/21/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

@objc protocol FilterViewDelegate {
    func returnSearchQueryString(searchParams: SearchParams)
}

class SearchParams: NSObject {
    var sortCategory: Int = 0
}


class FiltersViewController: UITableViewController, PickerViewCellDelegate {
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    var delegate: FilterViewDelegate?
    
    var searchParams: SearchParams = SearchParams()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        var viewCont = self.navigationController?.viewControllers
        self.delegate = viewCont?[0] as? FilterViewDelegate
        
        self.searchBarButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Bordered, target: self, action: "doSearch")
        self.navigationItem.rightBarButtonItem = self.searchBarButton
        
        self.filtersTableView.dataSource = self
        self.filtersTableView.delegate = self
        
        self.filtersTableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.filtersTableView.dequeueReusableCellWithIdentifier("PickerViewCell", forIndexPath: indexPath) as PickerViewCellTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    
    
    func doSearch() {
        self.delegate?.returnSearchQueryString(self.searchParams)
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onCancelFilters(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.greenColor()
        // Dispose of any resources that can be recreated.
    }
    
    func sortValue(message: String) {
        var id = 0
        switch message {
            case "best match":
                id = 1
            case "distance":
                id = 2
            case "highest rated":
                id = 3
            default:
                id = 0
            
        }
        self.searchParams.sortCategory = id
    }
    
    
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
