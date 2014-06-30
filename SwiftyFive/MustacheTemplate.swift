//
//  MustacheTemplate.swift
//  SwiftyFive
//
//  Created by Grant Warman on 6/27/14.
//  Copyright (c) 2014 BottleCap. All rights reserved.
//

import Foundation

class MustacheTemplate{
    let bracketRegex: String = "\\{\\{\\s*(\\w)\\s*\\}\\}"
    var templateString: String
    init(templateString: String){
        self.templateString = templateString
    }
    
    func render(object: Dictionary<String, String>)->String?{
        var renderString: String = self.templateString
        
        var error: NSError?
        var expression: NSRegularExpression = NSRegularExpression(pattern: bracketRegex, options: nil, error: &error)
        var matches: Array<String> = []
        
        var startIndex = 0
        
        while(startIndex < countElements(renderString) - 1){
            var result: NSTextCheckingResult! = expression.firstMatchInString(renderString, options: nil, range: NSMakeRange(startIndex, countElements(renderString) - startIndex))
            if !result{
                break
            }
            var bracketsRange: NSRange = result.range
            var keyRange: NSRange = result.rangeAtIndex(1)
            
            let key = (renderString as NSString).substringWithRange(keyRange)
            if let val = object[key]{
                startIndex = bracketsRange.location + countElements(val)
                renderString = (renderString as NSString).stringByReplacingCharactersInRange(bracketsRange, withString: val) as String
            }else{
                startIndex += bracketsRange.location + bracketsRange.length
            }
        }

        return renderString
    }
    
    func listTags()->Array<String>?{
        var error: NSError?
        var expression: NSRegularExpression = NSRegularExpression(pattern: bracketRegex, options: nil, error: &error)
        var matches: Array<String> = []
        
        expression.enumerateMatchesInString(self.templateString, options: nil, range: NSMakeRange(0, countElements(self.templateString))){
            (result : NSTextCheckingResult!, flags : NSMatchingFlags, ptr : CMutablePointer<ObjCBool>) in
                let string = (self.templateString as NSString).substringWithRange(result.rangeAtIndex(1))
                matches.append(string)
        }
        return matches
    }
}