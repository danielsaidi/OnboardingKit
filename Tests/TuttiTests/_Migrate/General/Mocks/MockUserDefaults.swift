////
////  MockOnboardingPersistence.swift
////  TuttiTests
////
////  Created by Daniel Saidi on 2020-07-20.
////  Copyright © 2020 Daniel Saidi. All rights reserved.
////
//
//import Foundation
//import Mockery
//
//class MockUserDefaults: UserDefaults, Mockable {
//    
//    lazy var boolRef = MockReference(bool)
//    lazy var arrayRef = MockReference(array)
//    lazy var dataRef = MockReference(data)
//    lazy var doubleRef = MockReference(double)
//    lazy var floatRef = MockReference(float)
//    lazy var integerRef = MockReference(integer)
//    lazy var objectRef = MockReference(object)
//    lazy var stringRef = MockReference(string)
//    lazy var urlRef = MockReference(url)
//    
//    lazy var setBoolRef = MockReference(set as (Bool, String) -> Void)
//    lazy var setDoubleRef = MockReference(set as (Double, String) -> Void)
//    lazy var setIntegerRef = MockReference(set as (Int, String) -> Void)
//    lazy var setFloatRef = MockReference(set as (Float, String) -> Void)
//    lazy var setUrlRef = MockReference(set as (URL?, String) -> Void)
//    lazy var setValueRef = MockReference(set as (Any?, String) -> Void)
//    
//    var mock = Mock()
//    
//    
//    override func array(forKey defaultName: String) -> [Any]? {
//        mock.invoke(arrayRef, args: defaultName)
//    }
//    
//    override func bool(forKey defaultName: String) -> Bool {
//        mock.invoke(boolRef, args: defaultName)
//    }
//    
//    override func data(forKey defaultName: String) -> Data? {
//        mock.invoke(dataRef, args: defaultName)
//    }
//    
//    override func double(forKey defaultName: String) -> Double {
//        mock.invoke(doubleRef, args: defaultName)
//    }
//    
//    override func float(forKey defaultName: String) -> Float {
//        mock.invoke(floatRef, args: defaultName)
//    }
//    
//    override func integer(forKey defaultName: String) -> Int {
//        mock.invoke(integerRef, args: defaultName)
//    }
//    
//    override func object(forKey defaultName: String) -> Any? {
//        mock.invoke(objectRef, args: defaultName)
//    }
//    
//    override func string(forKey defaultName: String) -> String? {
//        mock.invoke(stringRef, args: defaultName)
//    }
//    
//    override func url(forKey defaultName: String) -> URL? {
//        mock.invoke(urlRef, args: defaultName)
//    }
//    
//    override func set(_ value: Bool, forKey defaultName: String) {
//        mock.registerResult(for: boolRef) { _ in value }
//        mock.invoke(self.setBoolRef, args: (value, defaultName))
//    }
//    
//    override func set(_ value: Double, forKey defaultName: String) {
//        mock.registerResult(for: doubleRef) { _ in value }
//        mock.invoke(self.setDoubleRef, args: (value, defaultName))
//    }
//    
//    override func set(_ value: Float, forKey defaultName: String) {
//        mock.registerResult(for: floatRef) { _ in value }
//        mock.invoke(self.setFloatRef, args: (value, defaultName))
//    }
//    
//    override func set(_ url: URL?, forKey defaultName: String) {
//        mock.registerResult(for: urlRef) { _ in url }
//        mock.invoke(self.setUrlRef, args: (url, defaultName))
//    }
//    
//    override func set(_ value: Int, forKey defaultName: String) {
//        mock.registerResult(for: integerRef) { _ in value }
//        mock.invoke(self.setIntegerRef, args: (value, defaultName))
//    }
//    
//    override func set(_ value: Any?, forKey defaultName: String) {
//        mock.invoke(self.setValueRef, args: (value, defaultName))
//    }
//}
