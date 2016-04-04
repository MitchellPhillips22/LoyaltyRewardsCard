//
//  ViewController.swift
//  LoyaltyCard(Simple)
//
//  Created by Mitchell Phillips on 4/3/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func verifyButton(sender: UIButton) {
        
        showAlert()
        
    }
    @IBAction func selectAction(sender: UIButton) {
        
        buttonClicked(sender)
        
    }
    
    var verificationCode = "123456"
    
    var buttonsArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func buttonClicked(sender:UIButton) {
        
        sender.selected = !sender.selected
        if sender.selected == true {
            sender.setImage(UIImage(named: "selectedStar"), forState: UIControlState.Selected)
            buttonsArray.append(sender)
            print(buttonsArray.count)
        } else {
            sender.setImage(UIImage(named: "unselectedStar"), forState: UIControlState.Normal)
        }
    }

    func showAlert() {
        
        let alertController = UIAlertController(title: "Verify", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "Verify", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
            
            if textField!.text == self.verificationCode {
                print("approved")
                
            } else {
                
                for button in self.buttonsArray {
                    
                    if button.isKindOfClass(UIButton) {
                        button.selected = false
                    }
                    self.buttonsArray.removeAll()
                }
                
                
                
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

