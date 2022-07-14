//
//  UserManagerTest.swift
//  SwiftTemplateTests
//
//  Created by Cesar Castillo on 14-07-22.
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
        XCTAssertEqual(userToken, UserDefaults.standard.string(forKey: key))
    }
    
    func test_ShouldBeNilWhenSearchingForAnUnsavedToken() throws {
        // Given
        let sut = UserManager.shared

        // When
        let userToken = sut.userToken
        
        // Then
        XCTAssertNil(userToken)
    }
}
