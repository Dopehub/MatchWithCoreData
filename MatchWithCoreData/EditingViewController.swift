
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
    
    @IBOutlet weak var dueDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.match != nil){
            
            matchNameTf.text = self.match?.matchName
            matchDescriptionTf.text = self.match?.matchDescription
            dueDate.date = (self.match?.matchDate)!
        
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

        let dateStg = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyy"
        let todayDateInStg : String = dateFormatter.stringFromDate(dateStg)
        
        do {
        if (self.match == nil) {
            
                let match : Match =  Match(entity : enti! , insertIntoManagedObjectContext : context)
                match.matchId = "ID" + todayDateInStg
                match.matchDescription = matchDescriptionTf.text!
                match.matchName = matchNameTf.text!
                match.matchDate = dueDate.date
            print(match.matchId)
        }
        
        else {
                self.match?.setValue(todayDateInStg, forKey: "matchId")
                self.match?.setValue(self.matchNameTf.text!, forKey: "matchName")
                self.match?.setValue(self.matchDescriptionTf.text!, forKey: "matchDescription")
                self.match?.setValue(self.dueDate.date, forKey: "matchDate")
                
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
