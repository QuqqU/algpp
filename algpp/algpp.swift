//
//  algpp.swift
//  algpp
//
//  Created by 정기웅 on 31/12/2019.
//  Copyright © 2019 정기웅. All rights reserved.
//

import Foundation

enum OptionType: String {
    case abc = "1234"
}

class Algpp {
    
    private let consoleIO = ConsoleIO()
    let argc = CommandLine.argc
    let arguments = CommandLine.arguments
    
    func printUsage() {
        consoleIO.printUsage()
    }
    
    func runGPP(sourceFile: String) {
        let outFile = String(sourceFile.prefix(sourceFile.count - 4))
        let gpp = Process()
        let pipe = Pipe()
        
        gpp.executableURL = URL(fileURLWithPath: "/usr/bin/g++")
        gpp.arguments = ["-o", outFile, sourceFile]
        gpp.standardOutput = pipe
        
        do {
            try gpp.run()
            gpp.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: String.Encoding.utf8) {
                if output.isEmpty { runOutFile(outFile: outFile) }
                else { consoleIO.printMessage(output, type: .stdError) }
            }
        }
        catch { consoleIO.printMessage("g++: something wrong when g++'s running", type: .stdError) }
        
    }
    
    func runOutFile(outFile: String) {
        print("----")
        let out = Process()
        let pipe = Pipe()
        
        out.executableURL = URL(fileURLWithPath: "./\(outFile)")
        out.standardInput = FileHandle(forReadingAtPath: "./input.txt")
        out.standardOutput = pipe

        do {
            try out.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let result = String(data: data, encoding: String.Encoding.utf8) {
                if !result.isEmpty { consoleIO.printMessage(result, type: .stdOutput) }
                else { consoleIO.printMessage("\(outFile): check format of input", type: .stdError) }
            }
        }
        catch { consoleIO.printMessage("\(outFile): Something wrong when it's running", type: .stdError) }
    }
    
}

