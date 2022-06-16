//
//  ViewController.swift
//  Calculator
//
//  Created by OsamaSaberB based on Angela Yu Calculator repository
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber : Bool = true
    
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Connot convert display label text to double")
            } // end else
            return number
        }
        set {
            // To prevent AC button from showing displayLabel.text as "0.0"
            if String(newValue) != "0.0" {
                
                displayLabel.text = String(format: newValue.removeZerosFromEnd())
                
            } else {
                displayLabel.text = "0"
            }
        }
    } //End of displayValue
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod){
                
                displayValue = result
            } // End if let
            
        } // End calcMethod
        
    } // End calcButtonPressed
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                
                //To prevent display label from showing only "." as first character
                if numValue == "." && displayLabel.text?.first != "." {
                    displayLabel.text = "0."
                    isFinishedTypingNumber = false
                    return
                }
                displayLabel.text = numValue
                isFinishedTypingNumber = false
                
            } else {
                
                if numValue == "." {
                    
                    // to prevent the addision of another (.)
                    if displayLabel.text!.contains(".") {
                        return
                    } else {
                        let isInt = floor(displayValue) == displayValue // Bool expresion
                        if !isInt {
                            return
                        }
                    }
                    
                } // end if numValue
                displayLabel.text = displayLabel.text! + numValue
            }
        } // End if let numValue
    } //End numButtonPressed
}


// extension to remove trailing zeroes from an integer result
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
