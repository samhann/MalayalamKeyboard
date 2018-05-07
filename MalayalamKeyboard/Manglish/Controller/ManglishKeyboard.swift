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
    
    override func loadView() {
        super.loadView()
        
//        if let aBanner = self.createBanner() {
//            aBanner.hidden = true
//            self.view.insertSubview(aBanner, belowSubview: self.forwardingView)
//            self.bannerView = aBanner
//        }
        
       let suggestionsBar = TOMSSuggestionBarView(frame: CGRectMake(0,0,view.bounds.width,40), numberOfSuggestionFields: 3)
        self.view.insertSubview(suggestionsBar, aboveSubview: self.forwardingView)
//        suggestionsBar.
        
//        self.suggestionBarView = [[TOMSSuggestionBarView alloc] initWithFrame:[TOMSSuggestionBar suggestionBarFrame]
//            numberOfSuggestionFields:3];
        
    }
    
    override func setupKeys() {
        super.setupKeys()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            Translator.sharedInstance.loadWordSet()

        }
    }
    override func keyPressed(key: Key) {
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        currentWord += keyOutput
        
        if key.type == .Character || key.type == .SpecialCharacter || key.type == .Space || key.type == .Backspace{
            
            if key.type == .Space || key.type == .Backspace {
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
}
