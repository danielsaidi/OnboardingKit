////
////  MockOnboardingPersistence.swift
////  TuttiTests
////
////  Created by Daniel Saidi on 2018-06-18.
////  Copyright © 2018 Daniel Saidi. All rights reserved.
////
//
//import Tutti
//
//class MockOnboardingPersistence: OnboardingPersistence {
//    
//    
//    // MARK: - Mock Properties
//    
//    var boolValues = [String: Bool]()
//    var intValues = [String: Int]()
//    
//    var setIntInvokeCount = 0
//    var setIntInvokeValues = [Int]()
//    var setIntInvokeKeys = [String]()
//    
//    var setBoolInvokeCount = 0
//    var setBoolInvokeValues = [Bool]()
//    var setBoolInvokeKeys = [String]()
//    
//    
//    // MARK: - OnboardingPersistence
//    
//    func set(_ value: Int, forKey key: String) {
//        setIntInvokeCount += 1
//        setIntInvokeValues.append(value)
//        setIntInvokeKeys.append(key)
//    }
//    
//    func set(_ value: Bool, forKey key: String) {
//        setBoolInvokeCount += 1
//        setBoolInvokeValues.append(value)
//        setBoolInvokeKeys.append(key)
//    }
//    
//    func bool(forKey key: String) -> Bool {
//        boolValues[key] ?? false
//    }
//    
//    func integer(forKey key: String) -> Int {
//        intValues[key] ?? 0
//    }
//}
