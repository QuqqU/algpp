//
//  main.swift
//  algpp
//
//  Created by 정기웅 on 31/12/2019.
//  Copyright © 2019 정기웅. All rights reserved.
//

//#!/usr/bin/env swift
import Foundation

let algcc = Algcc()
//algcc.printUsage()
print(CommandLine.arguments)
algcc.runGPP(sourceFile: CommandLine.arguments[1] as String)

