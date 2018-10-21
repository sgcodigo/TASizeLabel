//
//  TASizeLabel.swift
//  TestDemo
//
//  Created by Thiha Aung on 10/17/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class TASizeLabel: UILabel {
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    // The size constant which is defined at stylesheet, you may set up as you want
    internal enum SizeLevel: Int {
        case HeadLineOne = 0 // 48 points
        case HeadLineTwo = 1// 36 points
        case Biggest = 2 // 32 points
        case Bigger = 3  // 24 points
        case Big = 4 // 20 Points
        case Medium = 5 // 18 points
        case Normal = 6 // 16 points
        case Small = 7 // 14 points
        case Smaller = 8 // 12 points
    }
    
    // Normal device sizes
    internal enum DeviceSize {
        case Small
        case Retina
        case HDRetina
        case SuperRetina
        case Other
    }
    
    // Programmatically: use the enum
    private var sizeLevel: SizeLevel = .Normal
    @IBInspectable var fontSizeLevel:Int {
        get {
            return self.sizeLevel.rawValue
        }
        set(sizeIndex) {
            self.sizeLevel = SizeLevel(rawValue: sizeIndex) ?? .Normal
        }
    }
    
    private var fontSize : CGFloat = 0.0
    private var pointSpecified: CGFloat = 0.0
    private var isResized: Bool = false
    
    // IB: use the adapter
    @IBInspectable var requiredResize: Bool = false {
        didSet{
            self.isResized = requiredResize
        }
    }
    
    @IBInspectable var kerningSpace: CGFloat = 0.0
    
    // The minimum size that you want to shrink on smaller device [Small].
    // Higher device will be automatically reduce to each based on that you defined.
    @IBInspectable var minimumSize: Int = 0
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        commonInit()
    }
    
    func commonInit(){
        self.controlFontSize(sizeLevel: sizeLevel, deviceSize: checkDevice())
        self.addCharactersSpacing(kerningSpace)
    }
    
    // For checking iPhone screens resolution
    private func checkDevice() -> DeviceSize{
        // Device Check
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 960:
                // "iPhone 4/4S"
                return .Small
            case 1136:
                // "iPhone 5/5S/5C"
                return .Small
            case 1334:
                // "iPhone 6/6S/7/8"
                return .Retina
            case 1920, 2208:
                // "iPhone 6+/6S+/7+/8+"
                return .HDRetina
            case 2436:
                // "iPhone X, Xs"
                return .SuperRetina
            case 2688:
                // "iPhone Xs Max"
                return .SuperRetina
            case 1792:
                // "iPhone Xr"
                return .SuperRetina
            default:
                return .Other
            }
        }else{
            return .Other
        }
    }
    
    func addCharactersSpacing(_ value: CGFloat) {
        if let textString = text {
            let attrs: [NSAttributedString.Key : Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }
    
    // Here lies the main changes
    private func controlFontSize(sizeLevel: SizeLevel, deviceSize: DeviceSize){
        
        // StyleSheet Font Sizes from higher to lower
        // HeadLineOne = 48 points
        // HeadLineTwo = 36 points
        // Biggest = 32 points
        // Bigger = 24 points
        // Big = 20 Points
        // Medium = 18 points
        // Normal = 16 points
        // Small = 14 points
        // Smaller = 12 points
        
        switch sizeLevel {
        case .Smaller:
            pointSpecified = 12
        case .Small:
            pointSpecified = 14
        case .Normal:
            pointSpecified = 16
        case .Medium:
            pointSpecified = 18
        case .Big:
            pointSpecified = 20
        case .Bigger:
            pointSpecified = 24
        case .Biggest:
            pointSpecified = 32
        case .HeadLineTwo:
            pointSpecified = 36
        case .HeadLineOne:
            pointSpecified = 48
        }
        
        self.fontSize = correctFontSizeForDevice(deviceSize: deviceSize, pointSpecified: pointSpecified)
        
        self.font = UIFont(name: self.font.fontName, size: fontSize)
    }
    
    private func correctFontSizeForDevice (deviceSize : DeviceSize, pointSpecified: CGFloat) -> CGFloat{
        switch deviceSize {
        case .Small:
            return checkReductionSize(minimumSize, pointSpecified, 15) // <= 15 is default set up, you can change as well
        case .Retina:
            return checkReductionSize(minimumSize - 5, pointSpecified, 10) // <= 10 is default set up, you can change as well
        case .HDRetina:
            return checkReductionSize(minimumSize - 10, pointSpecified, 5) // <= 5 is default set up, you can change as well
        case .SuperRetina, .Other:
            return pointSpecified
        }
    }
    
    private func checkReductionSize(_ reductionSize: Int,_ pointSpecified: CGFloat,_ defaultReductionSize: Int) -> CGFloat{
        if isResized{
            if reductionSize != 0 && reductionSize > 0{
                return pointSpecified - CGFloat(reductionSize)
            }else{
                return pointSpecified - CGFloat(defaultReductionSize)
            }
        }else{
            return pointSpecified
        }
    }
}
