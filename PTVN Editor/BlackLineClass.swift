//
//  BlackLineClass.swift
//  Labs Injections ROS
//
//  Created by Fool on 5/5/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

@IBDesignable
class MyLine: NSView {
	
	@IBInspectable
	var lineFillColor: NSColor = NSColor.darkGray
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func draw(_ dirtyRect: NSRect) {
		let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
		bPath.lineWidth = 0.0
		let fillColor = lineFillColor
		fillColor.setFill()
		bPath.fill()
		
		//super.drawRect(dirtyRect)
		
		
	}
	
}
