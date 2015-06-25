
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
    
    var match : Match?

    @IBOutlet weak var matchDescriptionTf: UITextField!
    @IBOutlet weak var matchNameTf: UITextField!
    @IBOutlet weak var matchIdTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.match != nil){
            
            matchIdTf.text = self.match?.matchId
            matchNameTf.text = self.match?.matchName
            matchDescriptionTf.text = self.match?.matchDescription
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let enti = NSEntityDescription.entityForName("Match", inManagedObjectContext: context)
        
        do {
        if (self.match == nil) {
            
                let match : Match =  Match(entity : enti! , insertIntoManagedObjectContext : context)
                match.matchId = matchIdTf.text!
                match.matchDescription = matchDescriptionTf.text!
                match.matchName = matchNameTf.text!
        }
        
        else {
                
                self.match?.setValue(self.matchIdTf.text!, forKey: "matchId")
                self.match?.setValue(self.matchNameTf.text!, forKey: "matchName")
                self.match?.setValue(self.matchDescriptionTf.text!, forKey: "matchDescription")
                
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
