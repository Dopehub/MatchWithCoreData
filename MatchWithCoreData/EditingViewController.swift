
//
//  EditingViewController.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/24/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit
import CoreData
import Parse

class EditingViewController: UIViewController {
    
    var serverId : String?

    @IBOutlet weak var rangeIpTf: UITextField?
    @IBOutlet weak var serverNameTf: UITextField?
    @IBOutlet weak var fQ: UITextField?
    @IBOutlet weak var tQ: UITextField?
    
    @IBOutlet weak var sQ: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.serverId != nil){
           
            let query = PFQuery(className:"Server")
            query.getObjectInBackgroundWithId(self.serverId!) {
                (server: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let server = server {
                    print(self.serverId!)
                    self.serverNameTf!.text! = (server.objectForKey("serverName") as? String)!
                    self.rangeIpTf!.text! = (server.objectForKey("rangeIp") as? String)!
                }
            }
            
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        if self.serverId == nil {
            
            let server = PFObject(className: "Server")
            server["serverName"] = self.serverNameTf!.text!
            server["rangeIp"] = self.rangeIpTf!.text!
            server.saveInBackground()
            
        
        }
        
        else {

            let query = PFQuery(className:"Server")
            query.getObjectInBackgroundWithId(self.serverId!) {
                (server: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let server = server {
                    
                    server["serverName"] = self.serverNameTf!.text!
                    server["rangeIp"] = self.rangeIpTf!.text!
                    server.saveInBackground()
                }
            }
            
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
