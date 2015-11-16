//
//  mainTableViewController.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData
import Parse

class mainTableViewController: UITableViewController {

    var serverList : Array<AnyObject> = []
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let query = PFQuery(className:"Server")
        do {
                        try serverList = query.findObjects()
            
                    }catch {
                        print("error")
                    }
        
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (self.serverList.count > 0 ) {return 1}
        else {return 0}
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return serverList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MyTableViewCell {
        
        let cell : MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyTableViewCell

        let data : PFObject = serverList[indexPath.row] as! PFObject
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let hourFormatter = NSDateFormatter()
        hourFormatter.dateFormat = "hh':'mm"
        let date = dateFormatter.stringFromDate((data.createdAt! as NSDate))
        let hour = hourFormatter.stringFromDate((data.createdAt! as NSDate))
        
        cell.titleText.text = data.objectForKey("serverName") as? String
        cell.descriptionText.text = data.objectForKey("rangeIp") as? String
        cell.dateLabelText.text = date
        cell.hourLabelText.text = hour

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextVc : EditingViewController = segue.destinationViewController as! EditingViewController
        if (segue.identifier == "editExistantSegue") {

            let indexPath : NSIndexPath! = self.tableView.indexPathForSelectedRow
            let data : PFObject = serverList[indexPath.row] as! PFObject
            nextVc.serverId = data.objectId
        }
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the Object from the database
//                let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                let context : NSManagedObjectContext = appDel.managedObjectContext
//                context.deleteObject(self.serverList[indexPath.row] as! NSManagedObject)
            let data : PFObject = self.serverList[indexPath.row] as! PFObject
            data.deleteInBackground()
            self.serverList.removeAtIndex(indexPath.row)
            data.saveInBackground()
            

            
            // Delete from tableView
            if (self.serverList.count>0) {
            
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            }
            
                else {
                
                tableView.deleteSections(NSIndexSet(index: indexPath.row), withRowAnimation: UITableViewRowAnimation.Fade)
            
            }
        
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


}
