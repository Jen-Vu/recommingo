//
//  RecommingoTests.swift
//  RecommingoTests
//
//  Created by Graeme Renfrew on 19/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import XCTest

class RecommingoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPost() {
        
        let caption = "This is the caption"
        let photoUrl = "http://www.test.com/picture.jpg"
        
        let post = Post(caption, photoUrl)
        
        XCTAssert(post.caption == caption, "The caption must match value passed in")
        XCTAssert(post.photoUrl == photoUrl, "The caption must match value passed in")
        
    
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
