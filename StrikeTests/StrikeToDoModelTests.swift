//
//  StrikeTests.swift
//  StrikeTests
//
//  Created by Joss Manger on 8/2/20.
//

import XCTest
@testable import Strike

class StrikeTests: XCTestCase {

    //MARK: ModelTests
    var model: ToDoModel!
  
    var testBody = ["title":"ThisIsMyTitle\(Int.random(in: 0...9999))",
                    "description":"This is My Description\(Int.random(in: 0...9999))"]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      model = ToDoModel(title: testBody["title"]!, description: testBody["description"]!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      model = nil
    }

    func testModelSetsUpWithValues() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      XCTAssert(model.title == testBody["title"]!)
    }
  
  func testModelSetsUpWithNotStartedState() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssert(model.state == .notStarted)
  }

  func testModelSetsUpWithTheSameDate() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssert(model.createdAt == model.lastUpdated)
  }

}
