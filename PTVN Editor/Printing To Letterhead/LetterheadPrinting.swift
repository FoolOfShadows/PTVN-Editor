//
//  LetterheadPrinting.swift
//  BrowserText
//
//  Created by Fool on 6/6/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Foundation
import Quartz

func printLetterheadWithText(_ text:String, fontName:String = "Times New Roman", fontSize: CGFloat = 12.0, window: NSWindow, andCloseWindow close: Bool = false, defaultCopies copies:Int = 1) {
    
    guard let img = NSImage(named: NSImage.Name("WPCM Letterhead Blank Cropped")) else { return }
    let imageView = NSImageView(frame: NSRect(origin: .zero, size: img.size))
    imageView.image = img
    
    let textView = NSTextView()
    textView.setFrameSize(NSSize(width: imageView.frame.width - 100, height: imageView.frame.height - 400))
    let theUserFont = NSFont(name: fontName, size: fontSize)
    let fontAttributes = NSDictionary(object: theUserFont!, forKey: NSAttributedString.Key.font as NSCopying)
    textView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
    
    textView.string = text
    
    imageView.addSubview(textView)
    textView.setFrameOrigin(NSPoint(x: imageView.frame.maxX - 575, y: imageView.frame.maxY - 125))
    
    let printOpts: [NSPrintInfo.AttributeKey: Any] = [NSPrintInfo.AttributeKey.copies: copies]
    let printInfo = NSPrintInfo(dictionary: printOpts)
    //This gets really close to fitting
    printInfo.horizontalPagination = .automatic
    printInfo.verticalPagination = .automatic
    printInfo.isVerticallyCentered = false
    
    
    printInfo.leftMargin = 0
    printInfo.rightMargin = 0
    printInfo.isHorizontallyCentered = false
    printInfo.topMargin = -600
    printInfo.bottomMargin = -100
    
    let operation:NSPrintOperation = NSPrintOperation(view:imageView, printInfo: printInfo)
    
    var theSelector:Selector? = nil
    
    if close == true {
        theSelector = #selector(window.close)

    }
    
    operation.runModal(for: window, delegate: window, didRun: theSelector, contextInfo: nil)
    //operation.run()

    
}

func printBlankPageWithText(_ text:String, fontName:String = "Times New Roman", fontSize: CGFloat = 12.0, window: NSWindow, andCloseWindow close: Bool = false, defaultCopies copies:Int = 1) {
    let textView = NSTextView(frame: NSRect(origin: .zero, size: CGSize(width: 612, height: 734)))
    
    
    let theUserFont = NSFont(name: fontName, size: fontSize)
    let fontAttributes = NSDictionary(object: theUserFont!, forKey: NSAttributedString.Key.font as NSCopying)
    textView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
    
    textView.string = text
    
    let printInfo = NSPrintInfo.shared
    //This gets really close to fitting
    printInfo.horizontalPagination = .fit
    printInfo.verticalPagination = .automatic
    printInfo.isVerticallyCentered = false
    
    printInfo.leftMargin = 70
    printInfo.rightMargin = 70
    printInfo.isHorizontallyCentered = false
    printInfo.topMargin = -600
    printInfo.bottomMargin = -100
    
    let operation:NSPrintOperation = NSPrintOperation(view: textView, printInfo: printInfo)
    
    var theSelector:Selector? = nil
    if close == true {
        theSelector = #selector(window.close)

    }
    
    operation.runModal(for: window, delegate: window, didRun: theSelector, contextInfo: nil)
    //operation.run()
    
}

func printLetterheadWithRichText(_ text:NSAttributedString, fontName:String = "Times New Roman", fontSize: CGFloat = 12.0, window: NSWindow, andCloseWindow close: Bool = false, defaultCopies copies:Int = 1) {
    
    guard let img = NSImage(named: NSImage.Name("WPCM Letterhead Blank Cropped")) else { return }
    let imageView = NSImageView(frame: NSRect(origin: .zero, size: img.size))
    imageView.image = img
    
    let textView = NSTextView()
    
    textView.setFrameSize(NSSize(width: imageView.frame.width - 100, height: imageView.frame.height - 400))
//    let theUserFont = NSFont(name: fontName, size: fontSize)
//    let fontAttributes = NSDictionary(object: theUserFont!, forKey: NSAttributedString.Key.font as NSCopying)
//    textView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]

    textView.textStorage?.setAttributedString(text)
    
    imageView.addSubview(textView)
    textView.setFrameOrigin(NSPoint(x: imageView.frame.maxX - 575, y: imageView.frame.maxY - 125))
    
    let printOpts: [NSPrintInfo.AttributeKey: Any] = [NSPrintInfo.AttributeKey.copies: copies]
    let printInfo = NSPrintInfo(dictionary: printOpts)
    //This gets really close to fitting
    printInfo.leftMargin = 0
    printInfo.rightMargin = 0
    printInfo.isHorizontallyCentered = false
    printInfo.topMargin = -600
    printInfo.bottomMargin = -100
    
    let operation:NSPrintOperation = NSPrintOperation(view:imageView, printInfo: printInfo)
    
    var theSelector:Selector? = nil
    
    if close == true {
        theSelector = #selector(window.close)

    }
    
    operation.runModal(for: window, delegate: window, didRun: theSelector, contextInfo: nil)
    //operation.run()

    
}
