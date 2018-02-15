//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Burak Tayfun on 2/12/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import SteemitApp

class NetworkManagerTests: XCTestCase {
    
    let nm: NetworkManager = NetworkManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSteemitAccount() {
        _ = stub(condition: isHost("api.steemjs.com")) { _ in
            let stubPath = OHPathForFile("SteemitAccount.json", type(of: self) as AnyClass)
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        let exp = expectation(description: "Wait for server response")
        
        nm.getSteemitAccount(user: "utopian-io", success: { (user) in
            XCTAssertEqual(user.username, "utopian-io")
            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }) { _ in
            XCTFail()
            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if error != nil {
                XCTFail()
                OHHTTPStubs.removeAllStubs()
            }
        }
    }
    
    func testSteemitAccountFollowerCount() {
        _ = stub(condition: isHost("api.steemjs.com")) { _ in
            let stubPath = OHPathForFile("SteemitAccountFollowerAndFollowingCount.json", type(of: self) as AnyClass)
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        let exp = expectation(description: "Wait for server response")
        
        nm.getSteemitAccountFollowerCount(user: "utopian-io", success: { (data) in
            if let followerCount = data["followerCount"] as? Int, let followingCount = data["followingCount"] as? Int {
                
                XCTAssertEqual(followingCount, 424)
                XCTAssertEqual(followerCount, 5942)
            } else {
                XCTFail()
            }

            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }) { _ in
            XCTFail()
            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if error != nil {
                XCTFail()
                OHHTTPStubs.removeAllStubs()
            }
        }
    }
    
    func testSteemitAccountFollowings() {
        _ = stub(condition: isHost("api.steemjs.com")) { _ in
            let stubPath = OHPathForFile("SteemitAccountFollowingList.json", type(of: self) as AnyClass)
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        let exp = expectation(description: "Wait for server response")
        
        nm.getSteemitAccountFollowings(user: "thornaci", limit: "100", success: { (followingList) in
            
            XCTAssert(followingList.contains("elear"))
            XCTAssert(followingList.contains("utopian-io"))
            
            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }) { _ in
            XCTFail()
            exp.fulfill()
            OHHTTPStubs.removeAllStubs()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if error != nil {
                XCTFail()
                OHHTTPStubs.removeAllStubs()
            }
        }
    }
}
