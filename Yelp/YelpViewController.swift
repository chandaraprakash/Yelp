//
//  ViewController.swift
//  Yelp
//
//  Created by Kumar, Chandaraprakash on 9/21/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import UIKit

class YelpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var yelpTableView: UITableView!

    
    var client: YelpClient!
    
    let yelpConsumerKey = "i_5o1ozB3Dh2R4e5V1z0Gg"
    let yelpConsumerSecret = "UB8gc1kfM4N89i_l9fNgMA1HJEM"
    let yelpToken = "GLmYiZv6S_5MP4weYJGt8MYzzmQdMjyV"
    let yelpTokenSecret = "9L3YCzJnOr95T3hi1cHSKKwMOkM"
    
    var allBusiness = [Business]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yelpTableView.dataSource = self
        self.yelpTableView.delegate = self
        //self.yelpTableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        client.searchWithTerm("Thai", success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            //process response for the view
            if let tmpBusiness = self.getBusinessFromResponseObject(response) {
                self.allBusiness = tmpBusiness
                self.yelpTableView.reloadData()
            }
            
            }) {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 2.0
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("I'm at \(indexPath.row) at section: \(indexPath.section)")
        var rowCount: Int = 1
        var cell = tableView.dequeueReusableCellWithIdentifier("com.kcp.yelpViewCell") as YelpTableViewCell
        
        if(self.allBusiness.count > 0) {
            cell.businessNameLabel.text =  "\(rowCount+indexPath.row).\(self.allBusiness[indexPath.row].businessName)"
            cell.listAddressLabel.text = self.allBusiness[indexPath.row].address
            cell.listReviewLabel.text = "\(self.allBusiness[indexPath.row].reviewCount) Reviews"
            cell.listDistanceLabel.text = "0.5mi"
            cell.listDollarLabel.text = "$$"
            
            var categories = self.allBusiness[indexPath.row].categories
            var listCategories: String = ""
            
            for category in categories{
                if(!listCategories.isEmpty){
                    listCategories = "\(listCategories), \(category[0])"
                }else{
                    listCategories = category[0]
                }
            }
            
            if(!listCategories.isEmpty){
                cell.listCategoryLabel.text = listCategories
            }
            
            if(!self.allBusiness[indexPath.row].thumbImageURL.isEmpty){
                cell.listImageView.setImageWithURL(NSURL(string: self.allBusiness[indexPath.row].thumbImageURL))
                //make imageview rounded corners
                cell.listImageView.layer.cornerRadius = 8.0
                cell.listImageView.clipsToBounds = true
            }
            
            if(!self.allBusiness[indexPath.row].ratingsImageURL.isEmpty){
                cell.listRatingsImageView.setImageWithURL(NSURL(string: self.allBusiness[indexPath.row].ratingsImageURL))
            }
            
            
        }
        
        return cell
    }
    
    func getBusinessFromResponseObject(response: AnyObject!) -> [Business]? {
        var isValidJSONObject = NSJSONSerialization.isValidJSONObject(response)
        
        if(isValidJSONObject) {
            let jsonData: NSData! = NSJSONSerialization.dataWithJSONObject(response, options: nil, error: nil)
            let jsonObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as NSDictionary
            var businessAll = [Business]()
            
            let allBusinessObj = jsonObject["businesses"] as [NSDictionary]
            for business in allBusinessObj {
                var businessObj = Business()
                businessObj.id = business["id"] as String
                businessObj.businessName = business["name"] as String
                businessObj.categories = business["categories"] as [[String]]
                businessObj.thumbImageURL = business["image_url"] as String
                businessObj.ratingsImageURL = business["rating_img_url"] as String
                businessObj.reviewCount = business["review_count"] as Int
                
                var location = business["location"] as NSDictionary
                var address = location["address"] as NSArray
                if(address.count > 0) {
                    businessObj.address = address[0] as String
                }
                
                businessAll += [businessObj]
            }
            return businessAll
        }
        return nil
    }


}

