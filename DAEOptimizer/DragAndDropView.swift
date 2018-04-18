//
//  DragAndDropView.swift
//  DAEOptimizer
//
//  Created by Ke Luo on 4/15/18.
//  Copyright © 2018 Ke Luo. All rights reserved.
//

import Cocoa

protocol DragAndDropViewDelegate: class {
  func dragAndDropView(_ dragAndDropView: DragAndDropView, didDropFileDirectory url: URL)
}

class DragAndDropView: NSView {
  
  // MARK: - Overrides
  
  weak var delegate: DragAndDropViewDelegate?
  
  // MARK: - Overrides
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    commonInit()
  }
  
  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    commonInit()
  }
  
  // MARK: - Private Methods
  
  private func commonInit() {
    registerForDraggedTypes([NSPasteboard.PasteboardType.URL])
  }
  
}

// MARK: - Drag and drop

extension DragAndDropView {
  
  func dragOperationForPasteboard(pasteboard: NSPasteboard) -> NSDragOperation {
    if let _ = NSURL(from: pasteboard) {
      return NSDragOperation.copy
    }
    return NSDragOperation()
  }
  
  func draggingUpdated(sender:NSDraggingInfo) -> NSDragOperation {
    return  self.dragOperationForPasteboard(pasteboard: sender.draggingPasteboard())
  }
  
  override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
    
    let pasteboard: NSPasteboard = draggingInfo.draggingPasteboard()
    if let fileURL = NSURL(from: pasteboard), let url = URL(string: fileURL.absoluteString ?? "") {
      delegate?.dragAndDropView(self, didDropFileDirectory: url)
      return true
    }
    return false
  }
  
  override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
    return  self.dragOperationForPasteboard(pasteboard: sender.draggingPasteboard())
  }
  
  
  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    return  self.dragOperationForPasteboard(pasteboard: sender.draggingPasteboard())
  }
  
  override func draggingExited(_ sender: NSDraggingInfo?) {
  }
}
