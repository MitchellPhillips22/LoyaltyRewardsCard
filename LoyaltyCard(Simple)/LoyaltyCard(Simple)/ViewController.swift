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
    
    @IBAction func verifyButton(sender: UIButton) {
        showAlert()
    }
    @IBAction func selectAction(sender: UIButton) {
        buttonClicked(sender)
    }
    
    @IBOutlet var latteButtonCollection: Array<UIButton>?
    
    @IBOutlet var coffeeButtonCollection: Array<UIButton>?
    
    var verificationCode = "123456"
 
    var stamps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in latteButtonCollection! {
            if button.tag <= stamps {
                button.selected = true
            }
            button.enabled = false
        }
        
    }
    
    //MARK: - Button functions
    
    func buttonClicked(sender:UIButton) {
        
        sender.selected = !sender.selected

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
       
                for button in self.latteButtonCollection! {
                    
                  button.enabled = true
                    
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
}

