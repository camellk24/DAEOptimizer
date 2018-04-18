//
//  DAEOptimizerTests.swift
//  DAEOptimizerTests
//
//  Created by Ke Luo on 4/15/18.
//  Copyright © 2018 Ke Luo. All rights reserved.
//

import XCTest
import SceneKit
@testable import DAEOptimizer

class DAEOptimizerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testConvertingDae() {
    
    let testExpectation = expectation(description: "test convert dae")

    // get dae file path
    let testModelUrl = Bundle.main.url(forResource: "duck", withExtension: "dae")!
    // get output file path
    let testOutputUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    let daeManager = DaeConversionManager()
    daeManager.convert(defaultDaesDirectoryPath: testModelUrl.absoluteString.removingFilePrefix().removingComponents(component: "duck.dae"), optimizedDaesDirectoryPath: testOutputUrl.absoluteString.removingFilePrefix(), outputUpdateHandler: { (_) in
      // do nothing
    }) {
      // appending duck.dae to destination
      let outputDaeUrl = testOutputUrl.appendingPathComponent("duck.dae")
      
      // assert optimized dae file can be loaded
      let scene = try? SCNScene(url: outputDaeUrl, options: .none)
      XCTAssertNotNil(scene)
      testExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 10.0) { (error) in
      XCTAssertNil(error)
    }
    
  }
  
}
