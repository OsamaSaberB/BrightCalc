//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Osama Saber on 23/05/2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number : Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    mutating func calculate (symbol: String) -> Double? {
        
        if let n = number {
            
            switch symbol {
        case "+/-":
            return n * -1
        case "AC":
            return 0
        case "%":
            return n / 100
        case "=":
            return performTwoNumCalc(n2: n)
        default:
            intermediateCalculation = (n1:n , calcMethod: symbol)
            }
            
        }
    return nil
} //end calculate


private  mutating func performTwoNumCalc (n2: Double) -> Double? {
    
    if let n1 = intermediateCalculation?.n1,
       let operation = intermediateCalculation?.calcMethod {
        
        switch operation {
            
        case "+":
            return n1 + n2
            
        case "×":
            return n1 * n2
            
        case "÷":
            return n1 / n2
            
        case "-":
            return n1 - n2
            
        default:
            fatalError("invalid operation")
            
        } // end switch
    }
    return nil
    
} //End func performTwonumCalc


}
