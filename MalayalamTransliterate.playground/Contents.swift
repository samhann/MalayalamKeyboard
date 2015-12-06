//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



//, "ഝ":



//"്രി": "R",
//"്രു": "R",

//, "ഃ":
//"ം":
// "ൗ": "9"


var mappings : [String : [String]] = [
    
    "a" : ["അ"] , "aa" : ["ആ","ാ"] , "m" : ["മ"] ,
    "b" :["ബ"] , "e" : ["ഏ","എ","െ","േ"] , "ai" : ["ഐ","ൈ"] , "i" : ["ഇ","ി"] ,
    "ee" : ["ഈ","ീ"] , "u" : ["ഉ","ു","്"] , "oo" : ["ഊ"] , "o" : ["ഒ","ഓ","ോ","ൊ"],
    "ou" : ["ഔ","ൌ"] , "r" : ["റ","ഋ","ർ","ര","ൃ"] , "k" : ["ക"] ,  "kh" : ["ഖ"] , "g" : ["ഗ"] , "gh" : ["ഘ"] , "ng" : ["ങ","ങ്ങ","ങ്ക"] , "ch" :["ച","ച്ച"] , "chh" : ["ഛ"] , "j" : ["ജ"] , "nj" : ["ഞ","ഞ്ഞ"],
    "d" : ["ട","ഢ","ഡ","ദ","ധ"] , "dh" : ["ഡ","ദ","ധ","ദ്ധ"] , "n" : ["ണ","ന","ൺ"] , "f" : ["ഫ"] , "t" : ["ഠ"] , "th" : ["ത","ഥ","ദ"] , "p" : ["പ"] , "bh" : ["ഭ"] , "y" :["യ"] ,
      "l" :["ല","ള"] , "v" : ["വ"] , "w" : ["വ"] ,"sh" : ["ശ","ഷ"] , "s" : ["സ"] , "h" : ["ഹ"] , "ll" : ["ല്ല","ള്ള"] , "zh" : ["ഴ"] , "il" : ["ൽ"] , "cl??" : ["ൾ"] , "kr" : ["ൿ"] , "kk" : ["ക്ക"] , "gg" : ["ഗ്ഗ"] , "jj":["ജ്ജ"] , "tt" : ["ട്ട","റ്റ"] , "nn" : ["ണ്ണ","ന്ന"] , "ksh" : ["ക്ഷ"] , "nt" : ["ന്റ"] , "nth" : ["ന്ത"] , "mp" : ["മ്പ"] , "thth" : ["ത്ത"] ,   "mm" : ["മ്മ"] , "vv" : ["വ്വ"] , "dd" : ["ദ്ധ","ദ്ദ"] , "bb" : ["ബ്ബ"] , "pp" : ["പ്പ"], "yy" :["യ്യ"] , "shsh" : ["ശ്ശ"] , "ss" : ["സ്സ"] , "ncha" : ["ഞ്ച"]]



func longestMatch(str : String)->(String?,String)
{
    var longest : String? = nil
    var rest : String = str
    
    for i in 0..<str.characters.count
    {
        
        let startIndex = advance(str.startIndex, 0) //advance as much as you like
        let endIndex = advance(str.startIndex, i)
        let range = startIndex...endIndex
        
        let sub = str.substringWithRange(range)
        
        
        if let match = mappings[sub] {
            longest = sub
            
            let start = advance(str.startIndex, i+1)
            let end   = advance(str.endIndex , 0)
            let restRange = start ..< end
            rest    = str.substringWithRange(restRange)
            
        }
        
    }
    
    return (longest,rest)
    
}

print(longestMatch("zh"))


var manglish : String = "mazha"

// this logic needs some tuning .... cant remove at the beginning or cant remove aa
var stringWithNoA : String = manglish.stringByReplacingOccurrencesOfString("a", withString: "")

var matches : [String] = []
var theString = stringWithNoA

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


var malayalamString = ""
print(matches)

for match in matches {
    malayalamString += mappings[match]![0]
}

print(malayalamString)

