//
//  Dare.swift
//  SwiftyFive
//
//  Created by Grant Warman on 6/27/14.
//  Copyright (c) 2014 BottleCap. All rights reserved.
//

import Foundation
class DareTemplate{
    
    var mustacheTemplate: MustacheTemplate
    var numberOfPeople: Int
    var nameIdentifiers: Array<String>
    
    init(templateString: String){
        mustacheTemplate = MustacheTemplate(templateString: templateString)
        nameIdentifiers = mustacheTemplate.listTags()!
        numberOfPeople = nameIdentifiers.count
    }
    
    func dareString(names: Array<String>) -> String?{
        if names.count != numberOfPeople{
            println("wrong number of people")
            return nil
        }
        var nameDict: Dictionary<String, String> = Dictionary<String, String>()
        for (index, name) in enumerate(nameIdentifiers){
            nameDict[name] = names[index]
        }
        
        println(nameDict)
        return mustacheTemplate.render(nameDict)
    }
}