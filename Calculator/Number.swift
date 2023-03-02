//
//  Number.swift
//  Calculator
//
//  Created by Walter Bernal Montero on 10/02/23.
//

import Foundation

struct Number {
    var numberString: String
    var numberDouble: Double {
        return NSString(string: numberString).doubleValue
    }
    var numberStringFormatted: String {
        let numberStringArray = Array(numberString)
        var formattedNumber = String()
        var decimalCount = 0
        var integerCount = 0
        var decimalPart = [String]()
        var integerPart = [String]()
        var toggle = true
        var characterCount = 0
        var hasPeriod = false
        
        ///divides the input in two parts, decimals and integers
        for character in numberStringArray {
            if toggle == true {
                if character != "." {
                    integerCount += 1
                    integerPart.append(character.lowercased())
                } else {
                    toggle = false
                    hasPeriod = true
                }
            } else {
                decimalCount += 1
                decimalPart.append(character.lowercased())
            }
        }
        
        /// integer part setup
        if integerPart.count > 0 {
            
            /// Removal of zero at left in integer part
            var i = 0
            if integerPart.count != 1 && integerPart[0] != "0" {
                toggle = true
                while i < integerCount {
                    if integerPart[i] == "0" {
                        characterCount += 1
                    } else {
                        i = integerCount
                    }
                    i += 1
                }
                i = 0
                while i < characterCount {
                    integerPart.remove(at: 0)
                    i += 1
                }
            }
            /// addition of commas in the integer part
            i = integerPart.count - 1
            while i > 0 {
                if characterCount % 3 == 2 {
                    integerPart.insert(",", at: i)
                }
                characterCount += 1
                i -= 1
            }
            ///avoids to add a comma  after a sign of minus
            if integerPart.count > 1 && integerPart[0] == "-" && integerPart[1] == "," {
                integerPart.remove(at: 1)
            }
        }
        
        // Set cientific notation if the integer character count is higher than 9 (999,999,999)
        if integerCount > 9 || decimalCount > 6 {
            formattedNumber = String(format: "%.2e", numberDouble)
        } else {
            for character in integerPart {
                formattedNumber += character
            }
            if hasPeriod == true {
                formattedNumber += "."
            }
            if decimalPart.count > 0 {
                for character in decimalPart {
                    formattedNumber += character
                }
            }
        }
        
        return formattedNumber
    }
}
