//
//  mainTableViewController.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData

class mainTableViewController: UITableViewController {

    var serverList : Array<AnyObject> = []
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
     
            let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context : NSManagedObjectContext = appDel.managedObjectContext
            let requ = NSFetchRequest(entityName: "Server")
           do {
            try serverList = context.executeFetchRequest(requ)
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

        let data : NSManagedObject = serverList[indexPath.row] as! NSManagedObject

        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyy"
        let dateFormatted :String = formatter.stringFromDate(data.valueForKeyPath("serverDateAdded") as! NSDate)
        
        let hformatter : NSDateFormatter = NSDateFormatter()
            hformatter.dateFormat = "hh:mm"
        let hourFormatted : String = hformatter.stringFromDate(data.valueForKeyPath("serverDateAdded") as! NSDate)
        
        cell.titleText.text = data.valueForKeyPath("serverName") as? String
        cell.descriptionText.text = data.valueForKeyPath("rangeIp") as? String
        cell.dateLabelText.text = dateFormatted
        cell.hourLabelText.text = hourFormatted

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextVc : EditingViewController = segue.destinationViewController as! EditingViewController
        if (segue.identifier == "editExistantSegue") {
            let indexPath = self.tableView.indexPathForSelectedRow
            let selectedServer = self.serverList[(indexPath?.row)!]
            nextVc.server = selectedServer as? Server
            
        }
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            do {
            // Delete the Object from the database
                let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context : NSManagedObjectContext = appDel.managedObjectContext
                context.deleteObject(self.serverList[indexPath.row] as! NSManagedObject)
                    do {
                    
                        try context.save()
                     }
                    catch{
                        print(error)
                    }
                let requ = NSFetchRequest(entityName: "Server")
                try serverList = context.executeFetchRequest(requ)
            }
            catch {
                print(error)
            }
            
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
