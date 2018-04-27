//
//  ThirdCustom.swift
//  CustomCheckboxExample
//
//  Created by Fool on 10/22/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

//Creates a circular checkbox button that is white when OFF, red when ON, and green when MIXED.
//The checkbox button cell needs to be set to this class rather than the button itself.
//To keep the top of the circle from clipping the heigth of the
//controller needs to be set to at least 20 (the default in IB is 19)
@IBDesignable
class RedGreenCheckbox: NSButtonCell {
	@IBInspectable
	var onStateColor: NSColor = NSColor.green
	@IBInspectable
	var offStateColor: NSColor = NSColor.white
	@IBInspectable
	var mixedStateColor: NSColor = NSColor.red
	
	override func drawImage(_ image: NSImage, withFrame frame: NSRect, in controlView: NSView) {
		
		let path = NSBezierPath(ovalIn: frame)
		//let path2 = NSBezierPath(roundedRect: frame, xRadius: 0.7, yRadius: 0.7)
		
		NSColor.black.setFill()
		//NSRectFill(frame)
		path.fill()
		
		let insetRect = NSInsetRect(frame, 0.5, 0.5)
		let insetPath = NSBezierPath(ovalIn: insetRect)
		//NSColor.white.setFill()
		//NSRectFill(NSInsetRect(frame, 1, 1))
		
		if self.allowsMixedState {
			if self.state == .on {
				//NSColor.greenColor().setFill()
				onStateColor.setFill()
			} else if self.state == .off {
				//NSColor.whiteColor().setFill()
				offStateColor.setFill()
			} else if self.state == .mixed {
				//NSColor.redColor().setFill()
				mixedStateColor.setFill()
			}
		} else {
			if self.state == .on {
				mixedStateColor.setFill()
			} else if self.state == .off {
				//NSColor.whiteColor().setFill()
				offStateColor.setFill()
				
			}
		}
		
		insetPath.fill()
		//NSRectFill(NSInsetRect(frame, 4, 4))
		
	}
    
    override func prepareForInterfaceBuilder() {
        
    }
}


@IBDesignable class coloredButton: NSButton {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    @IBInspectable var buttonColor:NSColor = NSColor.purple {
        didSet {
            sharedInit()
        }
    }
    
    func refreshColor(_ color:CGColor) {
        
    }
    
    func sharedInit() {
        //(self.cell as? NSButtonCell)?.isBordered = false
        (self.cell as? NSButtonCell)?.backgroundColor = buttonColor
        
    }
}

@IBDesignable class customButton: NSButton {
    @IBInspectable var bgColor:NSColor = NSColor.purple {
        didSet {
            self.layer?.backgroundColor = bgColor.cgColor
            self.title = title
        }
    }
    
    override func prepareForInterfaceBuilder() {
        self.layer?.backgroundColor = bgColor.cgColor
        self.title = title
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.layer?.backgroundColor = bgColor.cgColor
        bgColor.setFill()
        dirtyRect.fill()
        //NSRectFill(dirtyRect)
    }
}


@IBDesignable class ColorBlockView: NSButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }
    
    @IBInspectable var cornerRounding: CGFloat = 10 {
        didSet {
            layer?.cornerRadius = cornerRounding
        }
    }
    
    @IBInspectable var blockColor: NSColor = NSColor.red {
        didSet {
            layer?.backgroundColor = blockColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        layer?.backgroundColor = blockColor.cgColor
        layer?.cornerRadius = cornerRounding
    }
    
    override func awakeFromNib() {
        layer?.backgroundColor = blockColor.cgColor
        layer?.cornerRadius = cornerRounding
    }
}
//@IBDesignable
//class RedCheckbox: NSButtonCell {
//    @IBInspectable
//    var onStateColor: NSColor = NSColor.red
//    @IBInspectable
//    var offStateColor: NSColor = NSColor.white
////    @IBInspectable
////    var mixedStateColor: NSColor = NSColor.red
//
//    override func drawImage(_ image: NSImage, withFrame frame: NSRect, in controlView: NSView) {
//
//        let path = NSBezierPath(ovalIn: frame)
//        //let path2 = NSBezierPath(roundedRect: frame, xRadius: 0.7, yRadius: 0.7)
//
//        NSColor.black.setFill()
//        //NSRectFill(frame)
//        path.fill()
//
//        let insetRect = NSInsetRect(frame, 0.5, 0.5)
//        let insetPath = NSBezierPath(ovalIn: insetRect)
//        //NSColor.white.setFill()
//        //NSRectFill(NSInsetRect(frame, 1, 1))
//
//
//        if self.state == .on {
//            //NSColor.greenColor().setFill()
//            onStateColor.setFill()
//        } else if self.state == .off {
//            //NSColor.whiteColor().setFill()
//            offStateColor.setFill()
//        } /*else if self.state == .mixed {
//            //NSColor.redColor().setFill()
//            mixedStateColor.setFill()
//        }*/
//        insetPath.fill()
//        //NSRectFill(NSInsetRect(frame, 4, 4))
//
//    }
//}


//This version makes a circular controller rather than rectangular box
//To keep the top of the circle from clipping the heigth of the
//controller needs to be set to at least 20 (the default in IB is 19)
//@IBDesignable class RedGreenCheckboxButton: NSButton {
//    //Set up the fill colors and make them inspectable
//    @IBInspectable
//    var onStateColor: NSColor = NSColor.green
//    @IBInspectable
//    var offStateColor: NSColor = NSColor.white
//    @IBInspectable
//    var mixedStateColor: NSColor = NSColor.red
//
//    //Create the button itself
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        //Make the button show up as a circle
//        let path = NSBezierPath(ovalIn: dirtyRect)
//
//        //Fill the circle with black to create the effect of a border
//        NSColor.black.setFill()
//        path.fill()
//
//        //Create another circle inset into the first to show the state colors
//        let insetRect = NSInsetRect(dirtyRect, 0.5, 0.5)
//        let insetPath = NSBezierPath(ovalIn: insetRect)
//
//        //Check the state of the button to determine the color to show
//        if self.state == .on {
//            //NSColor.greenColor().setFill()
//            onStateColor.setFill()
//        } else if self.state == .off {
//            //NSColor.whiteColor().setFill()
//            offStateColor.setFill()
//        } else if self.state == .mixed {
//            //NSColor.redColor().setFill()
//            mixedStateColor.setFill()
//        }
//
//        //Fill in the inset circle with the correct color
//        insetPath.fill()
//    }
//}
