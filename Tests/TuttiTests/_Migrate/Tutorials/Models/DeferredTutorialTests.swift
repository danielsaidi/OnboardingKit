////
////  DeferredTutorialTests.swift
////  TuttiTests
////
////  Created by Daniel Saidi on 2018-06-19.
////  Copyright © 2018 Daniel Saidi. All rights reserved.
////
//
//import Quick
//import Nimble
//@testable import Tutti
//import Foundation
//import UIKit
//
//class DeferredTutorialTests: QuickSpec {
//    
//    override func spec() {
//        
//        var persistence: MockOnboardingPersistence!
//        
//        beforeEach {
//            persistence = MockOnboardingPersistence()
//        }
//        
//        func createTutorial(requiredPresentationAttempts: Int) -> DeferredTutorial {
//            DeferredTutorial(
//                identifier: "foo",
//                pageCount: 3,
//                requiredPresentationAttempts: requiredPresentationAttempts,
//                userId: "bar",
//                keySegmentSeparator: "baz",
//                persistence: persistence)
//        }
//        
//        
//        describe("when created") {
//            
//            it("sets all properties") {
//                let tutorial = createTutorial(requiredPresentationAttempts: 3)
//                expect(tutorial.identifier).to(equal("foo"))
//                expect(tutorial.pageCount).to(equal(3))
//                expect(tutorial.requiredPresentationAttempts).to(equal(3))
//                expect(tutorial.userId).to(equal("bar"))
//                expect(tutorial.keySegmentSeparator).to(equal("baz"))
//                expect(tutorial.persistence).to(be(persistence))
//            }
//            
//            it("uses user default persistence by default") {
//                let tutorial = DeferredTutorial(identifier: "", pageCount: 1, requiredPresentationAttempts: 121)
//                expect(tutorial.persistence).to(be(UserDefaults.standard))
//            }
//        }
//        
//        
//        describe("should be presented") {
//            
//            it("should be presented if it hasn't been displayed and the remaining presentation attempts is 0") {
//                let tutorial = createTutorial(requiredPresentationAttempts: 10)
//                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 10
//                expect(tutorial.shouldBePresented).to(beTrue())
//            }
//            
//            it("should not be presented if it has been displayed") {
//                let tutorial = createTutorial(requiredPresentationAttempts: 10)
//                persistence.boolValues[tutorial.hasBeenDisplayedKey] = true
//                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 10
//                expect(tutorial.shouldBePresented).to(beFalse())
//            }
//            
//            it("should not be presented if it has remaining presentation attempts") {
//                let tutorial = createTutorial(requiredPresentationAttempts: 10)
//                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 3
//                expect(tutorial.shouldBePresented).to(beFalse())
//            }
//        }
//    }
//}
