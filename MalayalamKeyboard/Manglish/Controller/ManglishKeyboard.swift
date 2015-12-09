//
//  ManglishKeyboard.swift
//  MalayalamKeyboard
//
//  Created by Anil Varghese on 08/12/15.
//  Copyright © 2015 ABC. All rights reserved.
//

import UIKit

class ManglishKeyboard: KeyboardViewController {
    
    var currentWord : String = ""
    var previousInsert :String = ""
    
    override func setupKeys() {
        super.setupKeys()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            Translator.sharedInstance.loadWordSet()

        }
    }
    override func keyPressed(key: Key) {
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        currentWord += keyOutput
        
        if key.type == .Character || key.type == .SpecialCharacter || key.type == .Space {
            
            if key.type == .Space {
                currentWord = ""
                previousInsert = ""
                textDocumentProxy.insertText(" ")
            }
            
            let possibleWords = Translator.sharedInstance.convertToManglishToPossibleWords(currentWord)
                
            if possibleWords.count > 0 {
                
                if(previousInsert.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {

                   var string = textDocumentProxy.documentContextBeforeInput!
                    var lastChar = string.characters.last
                    
                    while(lastChar != " ") {
                        textDocumentProxy.deleteBackward()
                        string = textDocumentProxy.documentContextBeforeInput ?? " "
                        lastChar = string.characters.last

                    }
                    
                }
                    textDocumentProxy.insertText(possibleWords.first!)
                    previousInsert = possibleWords.first!
            }
            
            
          

       }
        
        
       
    }
    func randomCat() -> String {
        let cats = "🐱😺😸😹😽😻😿😾😼🙀"
        
        let numCats = cats.characters.count
        let randomCat = arc4random() % UInt32(numCats)
        
        let index = cats.startIndex.advancedBy(Int(randomCat))
        let character = cats[index]
        
        return String(character)
    }
    
    
}
