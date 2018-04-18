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
  
  func convert(defaultDaesDirectoryPath: String, optimizedDaesDirectoryPath: String, outputUpdateHandler: @escaping (_ outputMessage: String) -> (), completion: @escaping () -> ()) {
    
    guard let scriptPath = Bundle.main.path(forResource: "copySceneKitAssets", ofType: "") else {
      fatalError("copySceneKitAssets not found!")
    }
    
    let task = Process()
    let pipe = Pipe()
    task.launchPath = scriptPath
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
    pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    
    NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable, object: pipe.fileHandleForReading, queue: .none) { (notification) in
      if let outputString = String(data: pipe.fileHandleForReading.availableData, encoding: String.Encoding.utf8) {
        DispatchQueue.main.async {
          outputUpdateHandler(outputString)
        }
      }
    }
  }
  
}
