//
//  String+Extension.swift
//  DAEOptimizer
//
//  Created by Ke Luo on 4/16/18.
//  Copyright © 2018 Ke Luo. All rights reserved.
//

import Foundation

extension String {
  
  func removingFilePrefix() -> String {
    var mutableUrlString = self
    if let rangeOfFilePrefix = range(of: "file://") {
      mutableUrlString.removeSubrange(rangeOfFilePrefix)
      return mutableUrlString
    }
    return self
  }
  
}
