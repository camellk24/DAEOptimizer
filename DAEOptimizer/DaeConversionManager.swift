//
//  DaeConversionManager.swift
//  DAEOptimizer
//
//  Created by Ke Luo on 4/16/18.
//  Copyright © 2018 Ke Luo. All rights reserved.
//

import Foundation

class DaeConversionManager {
  
  // MARK: - Public Methods
  
  
  
  static func convert(defaultDaesDirectoryPath: String, optimizedDaesDirectoryPath: String, completion: @escaping () -> ()) {
    
    guard let scriptPath = Bundle.main.path(forResource: "copySceneKitAssets", ofType: "") else {
      fatalError("copySceneKitAssets not found!")
    }
    
    let task = Process()
    let pipe = Pipe()
    
    /* Sample script:
     
     */
    
    print("\nscript path: /bin/sh \(scriptPath)\n")
    
    task.launchPath = scriptPath
    
    print("\narguements: \(defaultDaesDirectoryPath) -o \(optimizedDaesDirectoryPath)\n")
    task.arguments = [defaultDaesDirectoryPath, "-o", optimizedDaesDirectoryPath]
    task.standardOutput = pipe
    task.terminationHandler = { process in
      DispatchQueue.main.async {
        completion()
      }
    }
    task.launch()
    task.waitUntilExit()
    
    // Debug Message for shell
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)
    print("output: \(output)")
  }
  
}
