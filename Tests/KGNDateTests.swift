//
//  KGNDateTests.swift
//  KGNDateTests
//
//  Created by David Keegan on 9/08/16.
//  Copyright (c) 2016 David Keegan. All rights reserved.
//

import XCTest
@testable import KGNDate

class KGNDateRelativeTests: XCTestCase {
    
    func testRelativeFormatToday() {
        XCTAssertEqual(Date().relativeFormat(), "Today")
    }
    
    func testRelativeFormatYesterday() {
        XCTAssertEqual(Date().add(.day, -1).relativeFormat(), "Yesterday")
    }
    
    func testRelativeFormatTomorrow() {
        XCTAssertEqual(Date().add(.day, 1).relativeFormat(), "Tomorrow")
    }
    
}
