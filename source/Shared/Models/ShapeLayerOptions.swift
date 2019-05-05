//
//  ShapeLayer.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 5/5/19.
//  Copyright © 2019 Michael Hill. All rights reserved.
//

import Foundation

class ShapeLayerOptions: FaceLayerOptions {
    var indicatorType: FaceIndicatorTypes
    var indicatorSize: Float
    var patternTotal: Int
    var patternArray: [Int]
    
    //init from JSON, ( in from txt files )
    init(jsonObj: JSON ) {
        
        var patternArrayTemp = [Int]()
        if let patternArraySerialized = jsonObj["patternArray"].array {
            for patternSerialized in patternArraySerialized {
                patternArrayTemp.append( patternSerialized.intValue )
            }
        }
        
        let indicatorTypeString = jsonObj["indicatorType"].stringValue
        self.indicatorType = FaceIndicatorTypes(rawValue: indicatorTypeString)!
        
        self.indicatorSize = NSObject.floatValueForJSONObj(jsonObj: jsonObj, defaultVal: 0.0, key: "indicatorSize")
        self.patternTotal = NSObject.intValueForJSONObj(jsonObj: jsonObj, defaultVal: 12, key: "patternTotal")
        self.patternArray = patternArrayTemp
        
        super.init()
    }
    
    init(defaults: Bool ) {
        self.indicatorType = .FaceIndicatorTypeBox
        self.indicatorSize = 1.0
        self.patternTotal = 12
        self.patternArray = [1]
        
        super.init()
    }
    
    override func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "indicatorType" ] = self.indicatorType.rawValue as AnyObject
        serializedDict[ "indicatorSize" ] = self.indicatorSize.description as AnyObject
        
        serializedDict[ "patternTotal" ] = self.patternTotal.description as AnyObject
        serializedDict[ "patternArray" ] = self.patternArray as AnyObject
        
        return serializedDict as NSDictionary
    }
    
    static func ringTotalOptions() -> [String] {
        return [ "60", "24", "12", "4", "2" ]
    }
    
    static func ringPatterns() -> [String:NSArray] {
        return [
            "all on":[1],
            "all off":[0],
            "show every 3rd": [1,0,0],
            "hide every 3rd": [0,1,1],
            "show every 5th":[1,0,0,0,0],
            "hide every 5th":[0,1,1,1,1],
            "alternate off":[0,1],
            "alternate on":[1,0]
        ]
    }
    
    static func descriptionForRingPattern(_ ringPatternToFind: [Int]) -> String {
        let indexOfPattern = ClockRingSetting.ringPatternKeys().index( of: ringPatternToFind as NSArray )!
        return ringPatternDescriptions()[ indexOfPattern ]
    }
    
    static func patternForRingPatternDescription(_ ringPatternDescription: String) -> [Int] {
        let indexOfPatternDescription = ClockRingSetting.ringPatternDescriptions().index( of: ringPatternDescription )!
        return ringPatternKeys()[ indexOfPatternDescription ] as! [Int]
    }
    
    static func ringPatternDescriptions() -> [String] {
        var options = [String]()
        for (key,_) in ringPatterns() {
            options.append(key)
        }
        return options
    }
    
    static func ringPatternKeys() -> [NSArray] {
        var options = [NSArray]()
        for (_,values) in ringPatterns() {
            options.append(values)
        }
        return options
    }
    
    static func descriptionForRingType(_ nodeType: RingTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == RingTypes.RingTypeShapeNode)  { typeDescription = "Shape" }
        if (nodeType == RingTypes.RingTypeTextNode)  { typeDescription = "Text" }
        if (nodeType == RingTypes.RingTypeTextRotatingNode)  { typeDescription = "Rotating Text" }
        if (nodeType == RingTypes.RingTypeDigitalTime)  { typeDescription = "Date/Battery Text" }
        
        if (nodeType == RingTypes.RingTypeSpacer )  { typeDescription = "Empty Space" }
        
        return typeDescription
    }
    
    static func ringTypeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in RingTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForRingType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func ringTypeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in RingTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    static func descriptionForRingRenderShapes(_ nodeType: RingRenderShapes) -> String {
        var typeDescription = ""
        
        if (nodeType == RingRenderShapes.RingRenderShapeCircle)  { typeDescription = "Circle" }
        if (nodeType == RingRenderShapes.RingRenderShapeOval)  { typeDescription = "Oval" }
        if (nodeType == RingRenderShapes.RingRenderShapeRoundedRect)  { typeDescription = "Rectangle" }
        
        return typeDescription
    }
    
    static func ringRenderShapesDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in RingRenderShapes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForRingRenderShapes(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func ringRenderShapesKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in RingRenderShapes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
}
