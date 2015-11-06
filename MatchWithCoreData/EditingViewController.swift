
//
//  EditingViewController.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData

class EditingViewController: UIViewController {
    
    var server : Server?

    @IBOutlet weak var rangeIpTf: UITextField!
    @IBOutlet weak var serverNameTf: UITextField!
    @IBOutlet weak var fQ: UITextField!
    @IBOutlet weak var tQ: UITextField!
    
    @IBOutlet weak var sQ: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.server != nil){
            
            serverNameTf.text = self.server?.serverName
            rangeIpTf.text = self.server?.rangeIp
//            dueDate.date = (self.match?.matchDate)!
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let enti = NSEntityDescription.entityForName("Server", inManagedObjectContext: context)

        let dateStg = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyyhhmmss"
        let todayDateInStg : String = dateFormatter.stringFromDate(dateStg)
        
        do {
        if (self.server == nil) {
            
                let server : Server =  Server(entity : enti! , insertIntoManagedObjectContext : context)
                server.serverId = "ID" + todayDateInStg
                server.rangeIp = rangeIpTf.text!
                server.serverName = serverNameTf.text!
                server.serverDateAdded = dateStg
            print(server.serverId)
        }
        
        else {
//                self.match?.setValue(todayDateInStg, forKey: "matchId")
                self.server!.setValue(self.serverNameTf.text!, forKey: "serverName")
                self.server!.setValue(self.rangeIpTf.text!, forKey: "rangeIp")
//                self.match?.setValue(match?.matchDate, forKey: "matchDate")
            print(server!.serverId)
            
           }
            
            
        
        try context.save()

        }
        
        catch {
            print("error")
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
