//
//  ViewController.swift
//  LoyaltyCard(Simple)
//
//  Created by Mitchell Phillips on 4/3/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBAction func editTapped(sender: UIButton) {
        showAlert()
        checkForRedeemable()
    }
    
    @IBAction func selectAction(sender: UIButton) {
        buttonTapped(sender)
    }
    
    @IBAction func doneTapped(sender: UIButton) {
        saveDefaults()
        doneOutlet.hidden = true
        editOutlet.hidden = false
        updateUI()
    }

    @IBAction func redeemTapped(sender: UIButton) {
        stamps = 0
        updateUI()
    }
    
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var redeemOutlet: UIButton!
    
    @IBOutlet var latteButtonCollection: Array<UIButton>?
    
    @IBOutlet var coffeeButtonCollection: Array<UIButton>?
    
    var verificationCode = "4444"
 
    var stamps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
        checkForRedeemable()
        updateUI()
        
    }
    
    //MARK: - Button functions
    
    func buttonTapped(sender:UIButton) {
        
        if sender.selected == true {
            stamps = stamps - 1
            sender.selected = false
        } else {
            stamps = stamps + 1
            sender.selected = true
        }
        
        checkForRedeemable()
        
        print("stamps equals \(stamps)")

    }

    //MARK: - Alert set up
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Edit", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "Edit", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
                // test for verification
            if textField!.text == self.verificationCode {
                print("approved")
                self.stamps = 0
                self.loadDefaults()
                self.updateUI()
                
                for button in self.latteButtonCollection! {
                    
                  button.enabled = true
                  self.doneOutlet.hidden = false
                  self.editOutlet.hidden = true
                
                }
            } else {
                // fails authorization
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (alertAction) -> Void in
            
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        alertController.addAction(verifyAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    //MARK: - UI interaction functions
    func checkForRedeemable() {
        
        if self.stamps == 15 {
            self.redeemOutlet.hidden = false
        } else {
            self.redeemOutlet.hidden = true
        }
    }
    
    func updateUI() {
    
        for button in latteButtonCollection! {
            button.selected = false
            
            if button.tag <= stamps {
                button.selected = true
            }
            button.enabled = false
        }
        
    }
    
    //MARK: - NSUserDefaults functions
    func saveDefaults() {
        print("saved")
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = NSNumber(integer: self.stamps)
        defaults.setValue(number, forKey: "stampsNumber")
        defaults.synchronize()
        
    }
    
    func loadDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let value = defaults.valueForKey("stampsNumber") as? NSNumber {
            self.stamps = value.integerValue
        }
        print("loaded stamps \(stamps)")
        
    }
}

