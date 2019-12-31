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

class Algcc {
    
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
        gpp.standardError = pipe
        
        do {
            try gpp.run()
            gpp.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: String.Encoding.utf8) {
                if !output.isEmpty { consoleIO.printMessage(output, type: .stdError) }
                else {
                    
                    let execFile = Process()
                    let execPipe = Pipe()
                    print("-------")
                    execFile.executableURL = URL(fileURLWithPath: "/Users/jungkiung/Desktop/cli/aaa")
                    //execFile.standardInput = URL(fileURLWithPath: "/Users/jungkiung/Desktop/cli/input.txt")
                    execFile.standardInput = FileHandle(forReadingAtPath: "/Users/jungkiung/Desktop/cli/input.txt")
                    execFile.standardOutput = execPipe
                    print("-------")
                    do{
                        try execFile.run()
                        let dataa = execPipe.fileHandleForReading.readDataToEndOfFile()
                        let outp = String(data: dataa, encoding: String.Encoding.utf8)
                        consoleIO.printMessage(outp!, type: .stdOutput)
                        print("-------")
                    }catch{}
                }
            }
        }
        catch {
            consoleIO.printMessage("something wrong..... not developed yet", type: .stdError)
        }
        
    }
    
}

