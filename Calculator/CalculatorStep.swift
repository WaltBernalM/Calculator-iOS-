//
//  CalculatorStep.swift
//  Calculator
//
//  Created by Walter Bernal Montero on 12/02/23.
//

import Foundation

enum Operand {
    case sum
    case rest
    case mult
    case div
    case null
}

struct CalculatorStep {
    var operationStep: Operand
    var operationName: String {
        switch operationStep {
        case .sum:
            return "sum"
        case .rest:
            return "rest"
        case .mult:
            return "mult"
        case .div:
            return "div"
        case .null:
            return ""
        }
    }
    var operationSymbol: String {
        switch operationStep {
        case .sum:
            return "+"
        case .rest:
            return "-"
        case .mult:
            return "*"
        case .div:
            return "/"
        case .null:
            return ""
        }
    }
}


