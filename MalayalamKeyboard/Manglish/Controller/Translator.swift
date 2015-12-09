//
//  Translator.swift
//  MalayalamKeyboard
//
//  Created by Anil Varghese on 09/12/15.
//  Copyright © 2015 ABC. All rights reserved.
//

import UIKit

class Translator: NSObject {

    static var sharedInstance = Translator()
    var wordSet = Set<String>()
    
    
    func loadWordSet(){
        let path = NSBundle.mainBundle().pathForResource("mal_words", ofType: "txt")
        var data = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let myStrings = data.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        wordSet = Set(myStrings)
        
    }
    
    struct Sounds {
        
        var letters : [String]
        var vowels : [String]
    }
    
    
    var letterMappings : [String : Sounds] = [
        
        "a"     : Sounds(letters: ["അ"], vowels: ["","ാ"]),
        "aa"    : Sounds(letters: ["ആ"], vowels: ["ാ"]),
        "m"     : Sounds(letters: ["മ"], vowels: []),
        "b"     : Sounds(letters: ["ബ"], vowels: []),
        "e"     : Sounds(letters: ["ഏ","എ"], vowels: ["െ","േ"]),
        "ai"    : Sounds(letters: ["ഐ"], vowels: ["ൈ"]),
        "i"     : Sounds(letters: ["ഇ"], vowels: ["ി"]),
        "ee"    : Sounds(letters: ["ഈ"], vowels: ["ീ"]),
        "u"     : Sounds(letters: ["ഉ"], vowels: ["ു","്","ൂ"]),
        "oo"    : Sounds(letters: ["ഊ"], vowels: ["ൂ"]),
        "o"     : Sounds(letters: ["ഒ","ഓ"], vowels: ["ോ","ൊ"]),
        "ou"    : Sounds(letters: ["ഔ"], vowels: ["ീ"]),
        "r"     : Sounds(letters: ["റ","ഋ","ർ","ര"], vowels: []),
        "ru"    : Sounds(letters: ["ൃ"], vowels: []),
        "k"     : Sounds(letters:["ക"] ,vowels:[]) ,
        "kh"    : Sounds(letters:["ഖ"] ,vowels:[]) ,
        "g"     : Sounds(letters:["ഗ"] ,vowels:[]) ,
        "gh"    : Sounds(letters:["ഘ"] ,vowels:[] ) ,
        "ng"    : Sounds(letters:["ങ","ങ്ങ","ങ്ക"] ,vowels:[]) ,
        "ch"    :Sounds(letters:["ച","ച്ച"] ,vowels:[]) ,
        "chh"   : Sounds(letters:["ഛ"] ,vowels:[]) ,
        "j"     : Sounds(letters:["ജ"] ,vowels:[]) ,
        "nj"    : Sounds(letters:["ഞ","ഞ്ഞ"] ,vowels:[]),
        "d"     : Sounds(letters:["ട","ഢ","ഡ","ദ","ധ"] ,vowels:[]) ,
        "dh"    : Sounds(letters:["ഡ","ദ","ധ","ദ്ധ"] , vowels:[]) ,
        "n"     : Sounds(letters:["ണ","ന","ൺ","൯"] ,vowels:[]) ,
        "f"     : Sounds(letters:["ഫ"] ,vowels:[]) ,
        "t"     : Sounds(letters:["ഠ","ട്ട"] ,vowels:[]) ,
        "th"    : Sounds(letters:["ത","ഥ","ദ"] ,vowels:[]) ,
        "p"     : Sounds(letters:["പ"] ,vowels:[]) ,
        "bh"    : Sounds(letters:["ഭ"] ,vowels:[]) , "y" :Sounds(letters:["യ"] ,vowels:[]) ,
        "l"     :Sounds(letters:["ല","ള","ൾ"] ,vowels:[]) ,
        "v"     : Sounds(letters:["വ"] ,vowels:[]) ,
        "w"     : Sounds(letters:["വ"] ,vowels:[]) ,
        "sh"    : Sounds(letters:["ശ","ഷ"] ,vowels:[]) ,
        "s"     : Sounds(letters:["സ"] ,vowels:[]) ,
        "h"     : Sounds(letters:["ഹ"] ,vowels:[]) ,
        "ll"    : Sounds(letters:["ല്ല","ള്ള"] ,vowels:[]) ,
        "zh"    : Sounds(letters:["ഴ"] ,vowels:[]) ,
        "il"    : Sounds(letters:["ൽ"] ,vowels:[]) ,
        "kr"    : Sounds(letters:["ൿ"] ,vowels:[]) ,
        "kk"    : Sounds(letters:["ക്ക"] ,vowels:[]) ,
        "gg"    : Sounds(letters:["ഗ്ഗ"] ,vowels:[]) ,
        "jj"    :Sounds(letters:["ജ്ജ"] ,vowels:[]) ,
        "tt"    : Sounds(letters:["ട്ട","റ്റ"] ,vowels:[]) ,
        "nn"    : Sounds(letters:["ണ്ണ","ന്ന"] ,vowels:[]) ,
        "ksh"   : Sounds(letters:["ക്ഷ"] ,vowels:[]) ,
        "nt"    : Sounds(letters:["ന്റ"] ,vowels:[]) ,
        "nth"   : Sounds(letters:["ന്ത"] ,vowels:[]) ,
        "mp"    : Sounds(letters:["മ്പ"] ,vowels:[]) ,
        "thth"  : Sounds(letters:["ത്ത"] ,vowels:[]) ,
        "mm"    : Sounds(letters:["മ്മ"] ,vowels:[]) ,
        "vv"    : Sounds(letters:["വ്വ"] ,vowels:[]) ,
        "dd"    : Sounds(letters:["ദ്ധ","ദ്ദ"] ,vowels:[]) ,
        "bb"    : Sounds(letters:["ബ്ബ"] ,vowels:[]) ,
        "pp"    : Sounds(letters:["പ്പ"] ,vowels:[]),
        "yy"    :Sounds(letters:["യ്യ"] ,vowels:[]) ,
        "shsh"  : Sounds(letters:["ശ്ശ"] ,vowels:[]) ,
        "ss"    : Sounds(letters:["സ്സ"] ,vowels:[]) ,
        "nch"   : Sounds(letters:["ഞ്ച"] ,vowels:[]),
        "$"     : Sounds(letters: ["ം"], vowels: [])
        
    ]
    
    func longestMatch(str : String)->(String?,String)
    {
        var longest : String? = nil
        var rest : String = str
        
        for i in 0..<str.characters.count
        {
            
            let startIndex = str.startIndex.advancedBy(0) //advance as much as you like
            let endIndex = str.startIndex.advancedBy(i)
            let range = startIndex...endIndex
            
            let sub = str.substringWithRange(range)
            
            
            if let match = letterMappings[sub] {
                longest = sub
                
                let start = str.startIndex.advancedBy(i+1)
                let end   = str.endIndex.advancedBy(0)
                let restRange = start ..< end
                rest    = str.substringWithRange(restRange)
                
            }
            
        }
        
        return (longest,rest)
        
    }
    
    
    
    
    func preprocessWord(word : String) -> String
    {
        let consonantRegex = "([bcdfghjklmnpqrstvwxz])([bcdfghjklmnpqrstvwxz])"
        let manglish : String = word
        
        var manglishTwo : String = manglish.stringByReplacingOccurrencesOfString("am$", withString: "$", options: NSStringCompareOptions.RegularExpressionSearch, range: manglish.startIndex ..< manglish.endIndex)
        
        
        let range = manglishTwo.rangeOfString(consonantRegex, options: .RegularExpressionSearch)
        
        
        if let matchedRange = range {
            
            let match = manglishTwo[matchedRange]
            
            if letterMappings[match] == nil {
                manglishTwo = manglishTwo.stringByReplacingOccurrencesOfString(consonantRegex, withString: "$1u$2", options: NSStringCompareOptions.RegularExpressionSearch, range: manglishTwo.startIndex ..< manglishTwo.endIndex)
                
            }
        }
        
        
        
        
        
        return manglishTwo
    }
    
    
    
    
    func splitIntoMalluComponents(let theWord : String)->[String]
    {
        var matches : [String] = []
        var theString = preprocessWord(theWord)
        
        while (true) {
            var (match , rest) = longestMatch(theString)
            
            if let theMatch = match {
                matches.append(theMatch)
                theString = rest
            }
            else {
                break;
            }
        }
        
        
        return matches
    }
    
    
    
    
    
    
    func listOfListsForSounds(let matches : [String])->[[String]]
    {
        var matchedLists  : [[String]] = []
        
        for (index,match) in matches.enumerate() {
            
            var mapping = letterMappings[match]!
            
            // for first letter we can use the letter for a as in amma .. but in between the words we use vowel sound if its available
            if (mapping.vowels.count != 0 && index > 0) {
                matchedLists.append(mapping.vowels)
            }
            else {
                matchedLists.append(mapping.letters)
            }
        }
        
        return matchedLists
    }
    
    
    
    func flattenLists(var list : [[String]])->[String]
    {
        if (list.count == 0) {
            return []
        }
        
        if (list.count == 1) {
            return list[0]
        }
            
        else {
            
            let firstList = list[0]
            
            var anotherList = list
            anotherList.removeFirst()
            let flattenedRest =  flattenLists(anotherList)
            var returnList  : [String] = []
            
            for string in firstList {
                
                for rt in flattenedRest {
                    
                    returnList.append(string + rt)
                }
            }
            
            return returnList
        }
        
        
        
    }
    
    
    func convertToManglishToPossibleWords(let manglish: String)->[String]
    {
        let matches = splitIntoMalluComponents(manglish)
        let listOfLists = listOfListsForSounds(matches)
        let possibleWords = flattenLists(listOfLists)
//        let validWords    = possibleWords.filter { wordSet.contains($0) }
        
        return possibleWords
    }
}
