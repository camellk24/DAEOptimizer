//
//  ViewController.swift
//  DAEOptimizer
//
//  Created by Ke Luo on 4/15/18.
//  Copyright © 2018 Ke Luo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var dragAndDropView: DragAndDropView!
  @IBOutlet weak var outputPathControl: NSPathControl!
  @IBOutlet weak var messageLabel: NSTextField!
  @IBOutlet weak var outputTextView: NSTextView!
  
  // MARK: - Properties
  
  lazy var daeConversionManager = DaeConversionManager()
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dragAndDropView.delegate = self
    updateDragAndDropViewAppearance()
    
    if let urlString = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first, let url = URL(string: urlString) {
      outputPathControl.url = url
    }
  }
  
  // MARK: - Private Methods
  
  private func updateDragAndDropViewAppearance() {
    dragAndDropView.wantsLayer = true
    dragAndDropView.layer?.backgroundColor = NSColor(deviceRed: 0, green: 114/255, blue: 81/255, alpha: 1.0).cgColor
    dragAndDropView.layer?.cornerRadius = 5
  }
  
  private func showAlert(title: String, message: String) {
    DispatchQueue.main.async {
      let alert = NSAlert()
      alert.messageText = title
      alert.informativeText = message
      alert.alertStyle = .informational
      alert.addButton(withTitle: "OK")
      alert.runModal()
    }
  }
  
}

// MARK: - DragAndDropViewDelegate

extension ViewController: DragAndDropViewDelegate {
  
  func dragAndDropView(_ dragAndDropView: DragAndDropView, didDropFileDirectory url: URL) {
    
    guard let outputPath = outputPathControl.url?.absoluteString else {
      showAlert(title: "Missing Output Path", message: "Please select valid output path.")
      return
    }
    daeConversionManager.convert(defaultDaesDirectoryPath: url.absoluteString.removingFilePrefix(), optimizedDaesDirectoryPath: outputPath.removingFilePrefix(), outputUpdateHandler: { (outputString) in
     self.outputTextView.string = self.outputTextView.string + "\n> \(outputString)"
    }) {
//      self.showAlert(title: "Success", message: "Conversion done!")
    }
  }

}

