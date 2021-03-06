//
//  ViewController.swift
//  LoyaltyCard(Simple)
//
//  Created by Mitchell Phillips on 4/3/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func editTapped(sender: UIButton) {
        showAlert()
        checkForRedeemable()
    }
    
    @IBAction func selectAction(sender: UIButton) {
        latteButtonTapped(sender)
    }
    
    @IBAction func coffeeSelected(sender: UIButton) {
        coffeeButtonTapped(sender)
    }
    
    @IBAction func doneTapped(sender: UIButton) {
        saveDefaults()
        doneOutlet.hidden = true
        editOutlet.hidden = false
        isAuthorized = false
        updateUI()
    }
    
    @IBAction func redeemTapped(sender: UIButton) {
        if isAuthorized == true {
        latteStamps = 0
        redeemOutlet.hidden = true
        updateUI()
        }
    }
    @IBAction func redeemCoffeeTapped(sender: UIButton) {
        
        if isAuthorized == true {
        coffeeStamps = 0
        redeemCoffee.hidden = true
        updateUI()
        }
    }
    
    
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var redeemOutlet: UIButton!
    @IBOutlet weak var redeemCoffee: UIButton!
    @IBOutlet var latteButtonCollection: Array<UIButton>?
    
    @IBOutlet var coffeeButtonCollection: Array<UIButton>?
    
    var verificationCode = "4444"
    
    var latteStamps = 0
    
    var coffeeStamps = 0
    
    var isAuthorized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
        checkForRedeemable()
        updateUI()
        
    }
    // forces view to present in landscape only
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }
    //MARK: - Button functions
    
    func latteButtonTapped(sender:UIButton) {
        if isAuthorized == true {
            if sender.selected == true {
                latteStamps = latteStamps - 1
                sender.selected = false
            } else {
                latteStamps = latteStamps + 1
                sender.selected = true
            }
        }
        
        checkForRedeemable()
        
        print("stamps equals \(latteStamps)")
        
    }
    
    func coffeeButtonTapped(sender:UIButton) {
        if isAuthorized == true {
            if sender.selected == true {
                coffeeStamps = coffeeStamps - 1
                sender.selected = false
            } else {
                coffeeStamps = coffeeStamps + 1
                sender.selected = true
            }
        }
        checkForRedeemableCoffee()
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
                self.latteStamps = 0
                self.coffeeStamps = 0
                self.loadDefaults()
                self.updateUI()
                self.doneOutlet.hidden = false
                self.editOutlet.hidden = true
                self.isAuthorized = true
                
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
        
        if self.latteStamps == 15 {
            self.redeemOutlet.hidden = false
        } else {
            self.redeemOutlet.hidden = true
        }
    }
    func checkForRedeemableCoffee() {
        
        if self.coffeeStamps == 15 {
            self.redeemCoffee.hidden = false
        } else {
            self.redeemCoffee.hidden = true
        }
    }
    
    func updateUI() {
        
        for button in latteButtonCollection! {
            button.selected = false
            
            if button.tag <= latteStamps {
                button.selected = true
            }
            
        }
        for button in coffeeButtonCollection! {
            button.selected = false
            
            if button.tag <= coffeeStamps {
                button.selected = true
            }
            
        }
        
    }
    
    //MARK: - NSUserDefaults functions
    func saveDefaults() {
        print("saved")
        let defaults = NSUserDefaults.standardUserDefaults()
        let numberOfLattes = NSNumber(integer: self.latteStamps)
        let numberOfCoffees = NSNumber(integer: self.coffeeStamps)
        defaults.setValue(numberOfLattes, forKey: "stampsNumber")
        defaults.setValue(numberOfCoffees, forKey: "coffeeStamps")
        defaults.synchronize()
        
    }
    
    func loadDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let value = defaults.valueForKey("stampsNumber") as? NSNumber {
            self.latteStamps = value.integerValue
        }
        if let coffeeValue = defaults.valueForKey("coffeeStamps") as? NSNumber {
            self.coffeeStamps = coffeeValue.integerValue
        }
        print("loaded stamps \(latteStamps)")
        
    }
}

