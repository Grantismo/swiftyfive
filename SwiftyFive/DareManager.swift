//
//  DareManager.swift
//  SwiftyFive
//
//  Created by Grant Warman on 6/27/14.
//  Copyright (c) 2014 BottleCap. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> (T, i: Int) {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return (self[index], index)
    }
}

class DareManager{
    var dares: Array<String>!
    init(filename: String = "dares", type: String = "txt"){
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: type)
        var possibleContent = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: nil)
        
        if let content = possibleContent {
            self.dares = content.componentsSeparatedByString("\n")
        }
    }
    
    func dare(names: Array<String>)->String?{
        var dareTemplate: DareTemplate = self.randomDare()
        var numPeople: Int = dareTemplate.numberOfPeople
        println(numPeople)
        println(dareTemplate.mustacheTemplate.templateString)
        
        func choose<T: Any>(array: Array<T>, n: Int)->Array<T>?{
            if n > array.count{
                return nil
            }
            
            for i in 0..n{
                var (rand, randI) = array.randomItem()
                var temp: T = array[i]
                array[i] = rand
                array[randI] = temp
            }
            return Array(array[0..n])
        }
        
        var choices: Array<String>? = choose(names, numPeople)
        
        if choices{
            return dareTemplate.dareString(choices!)
        }else{
            return nil
        }
    }
    
    func randomDare()->DareTemplate{
        var (dare, i) = dares.randomItem()
        return DareTemplate(templateString: dare)
    }
}
