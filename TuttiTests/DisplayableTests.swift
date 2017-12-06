//
//  DisplayableTests.swift
//  TuttiTests
//
//  Created by Saidi Daniel (BookBeat) on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

fileprivate class TestDisplayable: Displayable {
    
    init(userId: String?) {
        self.userId = userId
    }
    
    var identifier = "foo"
    var userId: String?
}


class DisplayableTests: QuickSpec {
    
    override func spec() {
        
        var displayable: TestDisplayable!
        
        func set(key: String, to bool: Bool) {
            let defaults = UserDefaults.standard
            defaults.set(bool, forKey: key)
            defaults.synchronize()
        }
        
        
        context("user-unspecific") {
        
            let key = "com.danielsaidi.Tutti.foo"
            
            beforeEach {
                displayable = TestDisplayable(userId: nil)
            }
            
            afterEach {
                set(key: key, to: false)
            }
            
            describe("displayed state") {
                
                it("is false by default") {
                    expect(displayable.hasBeenDisplayed).to(beFalse())
                }
                
                it("is false if user defaults has no matching key") {
                    displayable.hasBeenDisplayed = true
                    set(key: key, to: false)
                    expect(displayable.hasBeenDisplayed).to(beFalse())
                }
                
                it("is true if user defaults has matching key") {
                    set(key: key, to: true)
                    expect(displayable.hasBeenDisplayed).to(beTrue())
                }
                
                it("is shared with another user-unspecific instance") {
                    displayable.hasBeenDisplayed = true
                    let anotherDisplayable = TestDisplayable(userId: nil)
                    expect(anotherDisplayable.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with a user-specific instance") {
                    displayable.hasBeenDisplayed = true
                    let anotherDisplayable = TestDisplayable(userId: "bar")
                    expect(anotherDisplayable.hasBeenDisplayed).to(beFalse())
                }
            }
        }
        
        
        context("user-specific") {
            
            let key = "com.danielsaidi.Tutti.foo.bar"
            
            beforeEach {
                displayable = TestDisplayable(userId: "bar")
            }
            
            afterEach {
                set(key: key, to: false)
            }
            
            describe("displayed state") {
                
                it("is false by default") {
                    expect(displayable.hasBeenDisplayed).to(beFalse())
                }
                
                it("is false if user defaults has no matching key") {
                    displayable.hasBeenDisplayed = true
                    set(key: key, to: false)
                    expect(displayable.hasBeenDisplayed).to(beFalse())
                }
                
                it("is true if user defaults has matching key") {
                    set(key: key, to: true)
                    expect(displayable.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with a user-unspecific instance") {
                    displayable.hasBeenDisplayed = true
                    let anotherDisplayable = TestDisplayable(userId: nil)
                    expect(anotherDisplayable.hasBeenDisplayed).to(beFalse())
                }
                
                it("is shared with another same user-specific instance") {
                    displayable.hasBeenDisplayed = true
                    let anotherDisplayable = TestDisplayable(userId: "bar")
                    expect(anotherDisplayable.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with another different user-specific instance") {
                    displayable.hasBeenDisplayed = true
                    let anotherDisplayable = TestDisplayable(userId: "barr")
                    expect(anotherDisplayable.hasBeenDisplayed).to(beFalse())
                }
            }
        }
    }
}
