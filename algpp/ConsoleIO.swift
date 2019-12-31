//
//  ConsoleIO.swift
//  algpp
//
//  Created by 정기웅 on 31/12/2019.
//  Copyright © 2019 정기웅. All rights reserved.
//

import Foundation

enum OutputType {
    case stdOutput
    case stdError
}

class ConsoleIO {
    
    func printMessage(_ message: String, type: OutputType) {
        switch type {
        case .stdOutput:
            print("\u{001B}[;m\(message)")
        case .stdError:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func printUsage() {
        let opcode = (CommandLine.arguments[0] as NSString).lastPathComponent
        printMessage("\(opcode): illegal option -- [options]", type: .stdError)
        printMessage("Usage: \(opcode) [-options] [file ...]", type: .stdError)
    }
    
    
}
