//
//  StrikeTodoModelTests.swift
//  StrikeTests
//
//  Created by Joss Manger on 8/3/20.
//

import XCTest
@testable import Strike

class StrikeTodoModelTests: XCTestCase {

  var testModel: StrikeModel!
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      testModel = TestModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      testModel = nil
    }

    func testCellsUpdateState() throws {
      
      testModel.models.forEach { (model) in
        let currentStatus = model.state
        testModel.cycleStatus(with: model.id)
        guard let updatedModel = testModel.models.first(where: { (innerModel) -> Bool in
          model.id == innerModel.id
        }) else {
          XCTFail()
          return
        }
        let nextState = updatedModel.state
        switch currentStatus {
        case .done:
          XCTAssert(nextState == .notStarted, "completed task did not changed to not started state")
        case .inProgress:
          XCTAssert(nextState == .done, "inProgress task did not changed to done state")
        case .notStarted:
          XCTAssert(nextState == .inProgress, "not started task did not changed to inProgress state")
        }
      }

    }
  
    
  func testInsert(){
    
    var count = testModel.models.count
    
    let newItem = ToDoModel(title: "Hello", description: "World")
    testModel.addModel(with: newItem.title, and: newItem.description)
    
    XCTAssert(testModel.models.count == (count+1), "the number of models has not incremented")
    count = testModel.models.count
    
  }
  
  func testRemove(){
    
    var count = testModel.models.count

    //testModel.deleteModels(with: IndexSet(integer: 0))
    testModel.models.remove(at: 0)
    
    XCTAssert(testModel.models.count == (count-1), "the number of models did not decremented")
    
    count = testModel.models.count
    
  }
  

}
