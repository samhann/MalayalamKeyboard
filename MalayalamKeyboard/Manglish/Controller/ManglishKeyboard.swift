//
//  ManglishKeyboard.swift
//  MalayalamKeyboard
//
//  Created by Anil Varghese on 08/12/15.
//  Copyright © 2015 ABC. All rights reserved.
//

import UIKit

class ManglishKeyboard: KeyboardViewController {
    
    override func setupKeys() {
        super.setupKeys()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            Translator.sharedInstance.loadWordSet()

        }
    }
    override func keyPressed(key: Key) {
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
//        if !NSUserDefaults.standardUserDefaults().boolForKey(kCatTypeEnabled) {
//            textDocumentProxy.insertText(keyOutput)
//            return
//        }
        
        if key.type == .Character || key.type == .SpecialCharacter {
            let context = textDocumentProxy.documentContextBeforeInput
            if context != nil {
                
                let possibleWords = Translator.sharedInstance.convertToManglishToPossibleWords(context!)
                
                if possibleWords.count > 0{
                    textDocumentProxy.insertText(possibleWords.first!)

                }else{
                    textDocumentProxy.insertText(keyOutput)
                }
//                if context!.characters.count < 2 {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//                
//                var index = context!.endIndex
//                
//                index = index.predecessor()
//                if context![index] != " " {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//                
//                index = index.predecessor()
//                if context![index] == " " {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//                
//                textDocumentProxy.insertText("\(randomCat())")
//                textDocumentProxy.insertText(" ")
//                textDocumentProxy.insertText(keyOutput)
                return
            }
            else {
                textDocumentProxy.insertText(keyOutput)
                return
            }
        }
        else {
            textDocumentProxy.insertText(keyOutput)
            return
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
