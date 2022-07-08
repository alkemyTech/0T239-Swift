//
//  UserManagerTests.swift
//  SwiftTemplateTests
//
//  Created by Cesar Castillo on 08-07-22.
//

import XCTest
@testable import SwiftTemplate

class UserManagerTests: XCTestCase {
    
    let key = "userToken"
    let userToken = "12345"
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func test_ShouldSaveUserTokenWhenCallSaveMethod() throws {
        // Given
        let sut = UserManager.shared
        
        // When
        sut.saveUserToken(token: userToken)
        
        // Then
        XCTAssertEqual(userToken, sut.userToken)
    }
    
    func test_ShouldSaveUserTokenInUserDefaults() throws {
        // Given
        let sut = UserManager.shared
        
        // When
        sut.saveUserToken(token: userToken)
        
        // Then
        XCTAssertEqual(userToken, UserDefaults.standard.string(forKey: key))
    }
}
