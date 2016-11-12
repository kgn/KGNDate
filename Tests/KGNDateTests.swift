//
//  KGNDateTests.swift
//  KGNDateTests
//
//  Created by David Keegan on 9/08/16.
//  Copyright (c) 2016 David Keegan. All rights reserved.
//

import XCTest
import Foundation
@testable import KGNDate

func date(from: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy-MM-dd"
    return formatter.date(from: from)!
}

// TODO: test add
// TODO: test component
class KGNDateTests: XCTestCase {
    
    func testOrdinal() {
        XCTAssertEqual(_ordinal(1), "st")
        XCTAssertEqual(_ordinal(2), "nd")
        XCTAssertEqual(_ordinal(3), "rd")
        XCTAssertEqual(_ordinal(4), "th")
        XCTAssertEqual(_ordinal(5), "th")
        XCTAssertEqual(_ordinal(6), "th")
        XCTAssertEqual(_ordinal(7), "th")
        XCTAssertEqual(_ordinal(8), "th")
        XCTAssertEqual(_ordinal(9), "th")
        XCTAssertEqual(_ordinal(10), "th")
        XCTAssertEqual(_ordinal(11), "th")
        XCTAssertEqual(_ordinal(12), "th")
        XCTAssertEqual(_ordinal(13), "th")
        XCTAssertEqual(_ordinal(14), "th")
        XCTAssertEqual(_ordinal(15), "th")
        XCTAssertEqual(_ordinal(16), "th")
        XCTAssertEqual(_ordinal(17), "th")
        XCTAssertEqual(_ordinal(18), "th")
        XCTAssertEqual(_ordinal(19), "th")
        XCTAssertEqual(_ordinal(20), "th")
        XCTAssertEqual(_ordinal(21), "st")
        XCTAssertEqual(_ordinal(22), "nd")
        XCTAssertEqual(_ordinal(23), "rd")
        XCTAssertEqual(_ordinal(24), "th")
        XCTAssertEqual(_ordinal(25), "th")
        XCTAssertEqual(_ordinal(26), "th")
        XCTAssertEqual(_ordinal(27), "th")
        XCTAssertEqual(_ordinal(28), "th")
        XCTAssertEqual(_ordinal(29), "th")
        XCTAssertEqual(_ordinal(30), "th")
        XCTAssertEqual(_ordinal(31), "st")
    }
    
}

// TODO: add time?
// TODO: test calanders
class KGNDateFormatTests: XCTestCase {

    func testFormat() {
        let format = date(from: "14-01-01").format()
        XCTAssertEqual(format, "January 1st, 2014")
    }
    
    func testFormatYearNone() {
        let format = date(from: "16-01-01").format(year: .none)
        XCTAssertEqual(format, "January 1st")
    }
    
    func testFormatYearShort() {
        let format = date(from: "16-02-02").format(year: .short)
        XCTAssertEqual(format, "February 2nd, 16")
    }
    
    func testFormatYearLong() {
        let format = date(from: "16-03-03").format(year: .long)
        XCTAssertEqual(format, "March 3rd, 2016")
    }
    
    func testFormatMonthNone() {
        let format = date(from: "16-04-04").format(month: .none)
        XCTAssertEqual(format, "4th, 2016")
    }
    
    func testFormatMonthShort() {
        let format = date(from: "16-05-05").format(month: .short)
        XCTAssertEqual(format, "May 5th, 2016")
    }
    
    func testFormatMonthLong() {
        let format = date(from: "16-06-06").format(month: .long)
        XCTAssertEqual(format, "June 6th, 2016")
    }
    
    func testFormatDayNone() {
        let format = date(from: "16-07-07").format(day: .none)
        XCTAssertEqual(format, "July, 2016")
    }
    
    func testFormatDayShort() {
        let format = date(from: "16-08-08").format(day: .short)
        XCTAssertEqual(format, "August 8, 2016")
    }
    
    func testFormatDayLong() {
        let format = date(from: "16-09-09").format(day: .long)
        XCTAssertEqual(format, "September 9th, 2016")
    }
    
}

// TODO: build out and test more
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
