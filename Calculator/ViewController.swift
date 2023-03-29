//
//  ViewController.swift
//  Calculator
//
//  Created by Walter Bernal Montero on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var deletButton: UIButton!
    @IBOutlet weak var massButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    @IBOutlet weak var sumButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var periodButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var screen: UILabel!
    @IBOutlet weak var statusScreen: UILabel!
    @IBOutlet weak var massScreen: UILabel!
    
    var inputArray = [String]()
    var input = Number.init(numberString: "")
    var answer = Number.init(numberString: "")
    var calculatorStep = CalculatorStep(operationStep: .null)
    var operand = ""
    var toggleMass = false
    var massInKg = Number.init(numberString: "")
    var massInLb = Number.init(numberString: "")
    var massText = [String]()
    var inputArrayFormatted = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        screen.text = ""
        massScreen.layer.cornerRadius = 25
        massScreen.layer.borderColor = UIColor.systemIndigo.cgColor
        massScreen.layer.borderWidth = 3
        updateMass()
        updateStatusDisplay(status: true, mass: true)
        
        setupButton(clearButton, color: .orange)
        setupButton(massButton, color: .systemIndigo)
        setupButton(deletButton, color: .lightGray)
        setupButton(divisionButton, color: .systemBlue)
        setupButton(multiplicationButton, color: .systemBlue)
        setupButton(restButton, color: .systemBlue)
        setupButton(sumButton, color: .systemBlue)
        setupButton(periodButton, color: .darkGray)
        setupButton(equalButton, color: .systemBlue)
        setupButton(zeroButton, color: .darkGray)
        setupButton(oneButton, color: .darkGray)
        setupButton(twoButton, color: .darkGray)
        setupButton(threeButton, color: .darkGray)
        setupButton(fourButton, color: .darkGray)
        setupButton(fiveButton, color: .darkGray)
        setupButton(sixButton, color: .darkGray)
        setupButton(sevenButton, color: .darkGray)
        setupButton(eightButton, color: .darkGray)
        setupButton(nineButton, color: .darkGray)
    }
    
    func setupButton(_ button: UIButton, color: UIColor) {
        let backgroundColor = color.cgColor
        button.layer.backgroundColor = backgroundColor
        button.tintColor = .clear
        button.layer.cornerRadius = 25
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        clearAll()
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        if Array(input.numberString).count > 0 {
            input.numberString.removeLast()
            screen.text = input.numberStringFormatted
        } else {
            screen.text = input.numberStringFormatted
            updateStatusDisplay(status: true, mass: false)
        }
    }
    
    @IBAction func massAction(_ sender: UIButton) {
        toggleMass.toggle()
        updateMass()
    }
    
    @IBAction func divisionAction(_ sender: UIButton) {
        userInputAppendcontrol()
        operandAppendControl("/")
        updateStatusDisplay(status: true, mass: false)
    }
    
    @IBAction func multiplicationAction(_ sender: UIButton) {
        userInputAppendcontrol()
        operandAppendControl("*")
        updateStatusDisplay(status: true, mass: false)
    }
    
    @IBAction func restAction(_ sender: UIButton) {
        userInputAppendcontrol()
        operandAppendControl("-")
        updateStatusDisplay(status: true, mass: false)
    }
    
    @IBAction func sumAction(_ sender: UIButton) {
        userInputAppendcontrol()
        operandAppendControl("+")
        updateStatusDisplay(status: true, mass: false)
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        isEqual()
    }
    
    @IBAction func periodButton(_ sender: UIButton) {
        addInputCharacter(".")
    }
    
    @IBAction func zeroAction(_ sender: UIButton) {
        addInputCharacter("0")
    }
    
    @IBAction func oneAction(_ sender: UIButton) {
        addInputCharacter("1")
    }
    
    @IBAction func twoAction(_ sender: UIButton) {
        addInputCharacter("2")
    }
    
    @IBAction func threeAction(_ sender: UIButton) {
        addInputCharacter("3")
    }
    
    @IBAction func fourAction(_ sender: UIButton) {
        addInputCharacter("4")
    }
    
    @IBAction func fiveAction(_ sender: UIButton) {
        addInputCharacter("5")
    }
    
    @IBAction func sixAction(_ sender: UIButton) {
        addInputCharacter("6")
    }
    
    @IBAction func sevenAction(_ sender: UIButton) {
        addInputCharacter("7")
    }
    
    @IBAction func eightAction(_ sender: UIButton) {
        addInputCharacter("8")
    }
    
    @IBAction func nineAction(_ sender: UIButton) {
        addInputCharacter("9")
    }
    
    func clearAll() {
        input.numberString = ""
        calculatorStep.operationStep = .null
        answer.numberString = ""
        screen.text = ""
        statusScreen.text = ""
        inputArray = []
        operandButtonhighlight()
        massInLb.numberString = ""
        massInKg.numberString = ""
        updateMass()
        inputArrayFormatted = []
        updateStatusDisplay(status: true, mass: true)
        
    }
    
    func addInputCharacter(_ string: String) {
        if input.numberString.count < 15 {
            if string == "." {
                if input.numberString.count == 0 {
                    input.numberString += "0."
                } else if !input.numberString.contains(".") {
                    input.numberString += "."
                }
            } else {
                input.numberString += string
            }
        }
        if inputArray.count > 0 && inputArray[0] == "-" {
            screen.text = "-\(input.numberStringFormatted)"
        } else {
            screen.text = input.numberStringFormatted
        }
        updateStatusDisplay(status: true, mass: false)
    }
    
    /// Rules for equal button
    func isEqual() {
        if !input.numberString.hasSuffix(".") {
            addInputCharacter(".0")
        }
        
        ///  appends to input array if there's any value available
        if !input.numberString.isEmpty {
            /// Discards the option of "0." and adds a zero at the end
            if input.numberString.count == 2 {
                if input.numberString == "0." {
                    input.numberString += "0"
                } 
            } else if Array(input.numberString)[input.numberString.count - 1] == "." {
                input.numberString += "0"
            }
            inputArray.append(input.numberString)
            inputArrayFormatted.append(input.numberStringFormatted)
        }
        
        if !inputArray.isEmpty {
            /// Discard any operand append to the array, this avoids crashes and bugs
            if inputArray.count == 1 && inputArray[0] == "-"{
               inputArray = ["0"]
            } else if inputArray[inputArray.count - 1] == "+" {
                inputArray.remove(at: inputArray.count - 1)
            } else if inputArray[inputArray.count - 1] == "-" {
                inputArray.remove(at: inputArray.count - 1)
            } else if inputArray[inputArray.count - 1] == "*" {
                inputArray.remove(at: inputArray.count - 1)
            } else if inputArray[inputArray.count - 1] == "/" {
                inputArray.remove(at: inputArray.count - 1)
            }
            /// Processes the array and converts it from a string to the math solution, and shows it in String type.
            answer.numberString = String(stringToMath(disolveStringArray(inputArray)))
            screen.text = answer.numberStringFormatted
            
        } else if !answer.numberString.isEmpty {
            screen.text = answer.numberStringFormatted
        } else {
            answer.numberString = ""
            screen.text = answer.numberStringFormatted
        }
        calculatorStep.operationStep = .null
        operandButtonhighlight()
        updateMass()
        updateStatusDisplay(status: true, mass: true)
        input.numberString = ""
        inputArray = []
        inputArrayFormatted = []
    }
    
    /// Rules for user input appendix
    func userInputAppendcontrol() {
        if !input.numberString.hasSuffix(".") {
            addInputCharacter(".0")
        }
        
        if inputArray.count == 0 && !input.numberString.isEmpty { //If the input array is empty and the entry isn't, append the input to the input array. And displays the input
            if input.numberString == "0."{
                input.numberString += "0"
            }
            inputArray.append(String(input.numberString))
            inputArrayFormatted.append(input.numberStringFormatted)
            input.numberString = ""
            updateStatusDisplay(status: true, mass: false)
        } else if inputArray.count > 0 && inputArray.count < 2 && !input.numberString.isEmpty { // If in the array are data but is below 2, appends the input, and displays the input
            if input.numberString == "0."{
                input.numberString += "0"
            }
            inputArray.append(input.numberString)
            inputArrayFormatted.append(input.numberStringFormatted)
            screen.text = input.numberStringFormatted
            input.numberString = ""
        } else if inputArray.count >= 2 && !input.numberString.isEmpty { // If the data in the array is equal or higher than 2, appends the input to the array and displays the answer.
            if input.numberString == "0."{
                input.numberString += "0"
            }
            inputArray.append(input.numberString)
            inputArrayFormatted.append(input.numberStringFormatted)
            answer.numberString = String(stringToMath(disolveStringArray(inputArray)))
            screen.text = answer.numberStringFormatted
            input.numberString = ""
        }
        
        if inputArray.isEmpty && !answer.numberString.isEmpty { //If the array is empty and the answer is not empty, appends the answer to the array.
            inputArray.append(answer.numberString)
            inputArrayFormatted.append(answer.numberStringFormatted)
        }
        
        updateMass()
    }
    
    
    func operandAppendControl(_ operand: String) {
        /// Rules for operand appendix
        
        /// Avoids the stacking of operands
        let operandCount = operandCounter(toDelete: true).operandCount
        var index = inputArray.count - 1
        if operandCount > 1 {
            index = operandCount
            while index > 0 {
                inputArray.remove(at: inputArray.count - 1)
                inputArrayFormatted.remove(at: inputArrayFormatted.count - 1)
                index -= 1
            }
        }
        
        if screen.text == "-0" && operand != "-" {
            screen.text = ""
        }
        
        ///avoidance of operand doubble append
        if inputArray.count > 0 {
            /// Addition of negative numbers
            if inputArray.count > 1 && operand == "-" {
                if inputArray[inputArray.count - 1] == "*" || inputArray[inputArray.count - 1] == "/" {
                    inputArray.append("-")
                    inputArrayFormatted.append("-")
                }
            } 
            
            /// Avoidance of same operand append in same click
            if inputArray[inputArray.count - 1] == "+" { //avoids operand double append for sum
                avoidDuplicateAppend(operand: operand)
            } else if inputArray[inputArray.count - 1] == "-" { //avoids operand double append for rest
                avoidDuplicateAppend(operand: operand)
            } else if (inputArray[inputArray.count - 1] == "*") { //avoids operand double append for mult
                avoidDuplicateAppend(operand: operand)
            } else if inputArray[inputArray.count - 1] == "/" { //avoids operand double append for div
                avoidDuplicateAppend(operand: operand)
            } else if inputArray[inputArray.count - 1] != operand { // Appends the operand if there's none and if is not the first one.
                inputArray.append(operand)
                if operand == "/" {
                    inputArrayFormatted.append("÷")
                } else if operand == "*" {
                    inputArrayFormatted.append("×")
                } else {
                    inputArrayFormatted.append(operand)
                }
                operationStepControl(operand)
            }
        } else if inputArray.count == 0 && operand == "-" { /// enables the possibility to have negative decimal numbers
            inputArray.append("-")
            inputArrayFormatted.append("-")
            calculatorStep.operationStep = .null
            screen.text = "-0"
        }
        
        ///  Disables the option to have operands if the inputarray size is equal to 1
        if inputArray.count == 1 {
            if inputArray[0] == "+" {
                inputArray.remove(at: inputArray.startIndex)
                inputArrayFormatted.remove(at: inputArrayFormatted.startIndex)
                calculatorStep.operationStep = .null
            } else if inputArray[0] == "-" {
                calculatorStep.operationStep = .null
            }
            else if inputArray[0] == "*" {
                inputArray.remove(at: inputArray.startIndex)
                inputArrayFormatted.remove(at: inputArrayFormatted.startIndex)
                calculatorStep.operationStep = .null
            }  else if inputArray[0] == "/" {
                inputArray.remove(at: inputArray.startIndex)
                inputArrayFormatted.remove(at: inputArrayFormatted.startIndex)
                calculatorStep.operationStep = .null
            }
        }
        
        /// Function to highlight the used operand button based in the calulator step status
        operandButtonhighlight()
    }
    
    func avoidDuplicateAppend(operand: String) {
        inputArray.remove(at: inputArray.count - 1)
        inputArrayFormatted.remove(at: inputArrayFormatted.count - 1)
        inputArray.append(operand)
        if operand == "/" {
            inputArrayFormatted.append("÷")
        } else if operand == "*" {
            inputArrayFormatted.append("×")
        } else {
            inputArrayFormatted.append(operand)
        }
        operationStepControl(operand)
    }
    
    func operationStepControl(_ operand: String) {
        switch operand {
        case "+":
            return calculatorStep.operationStep = .sum
        case "-":
            return calculatorStep.operationStep = .rest
        case "*":
            return calculatorStep.operationStep = .mult
        case "/":
            return calculatorStep.operationStep = .div
        default:
            return calculatorStep.operationStep = .null
        }
    }
    
    func operandButtonhighlight() {
        switch calculatorStep.operationStep {
        case .sum:
            return setColor(button: sumButton)
        case .rest:
            return setColor(button: restButton)
        case .mult:
            return setColor(button: multiplicationButton)
        case .div:
            return setColor(button: divisionButton)
        case .null:
            return restoreColor()
        }
    }
    
    func setColor(button: UIButton) {
        let highligthColor = UIColor(red: 38/255, green: 91/255, blue: 185/255, alpha: 1)
        setupButton(sumButton, color: .systemBlue)
        setupButton(restButton, color: .systemBlue)
        setupButton(multiplicationButton, color: .systemBlue)
        setupButton(divisionButton, color: .systemBlue)
        setupButton(button, color: highligthColor)
    }
    
    func restoreColor() {
        setupButton(sumButton, color: .systemBlue)
        setupButton(restButton, color: .systemBlue)
        setupButton(multiplicationButton, color: .systemBlue)
        setupButton(divisionButton, color: .systemBlue)
    }
    
    func updateStatusDisplay(status: Bool, mass: Bool) {
        print("\nanswer.numberString: \(answer.numberString) \ninputArray: \(inputArray) \ninputCount: \(input.numberString.count) \ninput.numberString: \(input.numberString) \ninputFormattedNumber: \(input.numberStringFormatted) \ninputFormatted: \(String(input.numberStringFormatted)) \ninputArrayFormatted: \(disolveStringArray(inputArrayFormatted)) \ncalculatorStep: \(calculatorStep.operationName)")
        if status == true {
            statusScreen.text = "\(disolveStringArray(inputArrayFormatted))"
        }
        if mass == true {
            massScreen.text = "\(massText[0])\n\(massText[1])\n\(massText[2])"
        }
    }
    
    func disolveStringArray(_ array: [String]) -> String {
        var unifiedString = String()
        for index in array {
            unifiedString += index
            unifiedString += " "
        }
        return unifiedString
    }
    
    func stringToMath(_ string: String) -> Double {
        let expn = NSExpression(format: string)
        return expn.expressionValue(with: Double.self, context: nil) as! Double
    }

    func updateMass() {
        if answer.numberDouble == 0 {
            massInLb.numberString = "0.00"
            massInKg.numberString = "0.00"
            if toggleMass == true {
                massText = [
                    "\(String(format: "%.1f", 0.0)) lb",
                    "⏷",
                    "\(String(format: "%.1f", 0.0)) kg"
                ]
            } else {
                massText = [
                    "\(String(format: "%.1f", 0.0)) kg",
                    "⏷",
                    "\(String(format: "%.1f", 0.0)) lb"
                ]
            }
        } else {
            let initialMass = Number(numberString: String(format: "%.1f", answer.numberDouble))
            massInKg.numberString = String(format: "%.1f", answer.numberDouble * 0.4535) //lb to kg
            massInLb.numberString = String(format: "%.1f", answer.numberDouble * 2.2046) // kg to lb
            if initialMass.numberStringFormatted.count < 9 || massInLb.numberStringFormatted.count < 9 || massInKg.numberStringFormatted.count < 9 {
                if toggleMass == true {
                    massText = [
                        "\(String(initialMass.numberStringFormatted)) lb",
                        "⏷",
                        "\(String(massInKg.numberStringFormatted)) kg"
                    ]
                } else {
                    massText = [
                        "\(String(initialMass.numberStringFormatted)) kg",
                        "⏷",
                        "\(String(massInLb.numberStringFormatted)) lb"
                    ]
                }
            } else {
                massText = ["Too big","to","show"]
            }
        }
        updateStatusDisplay(status: false, mass: true)
    }
    
    func operandCounter(toDelete: Bool) -> (operandCount: Int, operandArray: [String]) {
        var count = 0
        var index = inputArray.count - 1
        var operandArray = [String]()
        while index > 0 {
            if inputArray[index] == "+" {
                count += 1
                operandArray.append("+")
            } else if inputArray[index] == "-" {
                count += 1
                operandArray.append("-")
            } else if inputArray[index] == "*" {
                count += 1
                operandArray.append("*")
            } else if inputArray[index] == "/" {
                count += 1
                operandArray.append("/")
            } else {
                if toDelete == true {
                    index = 0
                }
            }
            index -= 1
        }
        return (count, operandArray)
    }
}
