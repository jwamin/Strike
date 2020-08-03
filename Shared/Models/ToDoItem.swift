//
//  ToDoItem.swift
//  Strike
//
//  Created by Joss Manger on 8/3/20.
//

import Foundation

struct ToDoModel: Identifiable, Codable {
  
  enum Status: Int, Codable {
    case notStarted
    case inProgress
    case done
  }
  
  init(title:String,description: String){
    
    self.title = title
    self.description = description
    self.state = .notStarted
    let now = Date()
    createdAt = now
    lastUpdated = now
    
  }
  
  init(title: String, description: String, createdAt: Date, lastUpdated: Date, state:ToDoModel.Status){
    self.title = title
    self.description = description
    self.createdAt = createdAt
    self.lastUpdated = lastUpdated
    self.state = state
  }
  
  var id: UUID = UUID()
  var title: String
  var description: String
  var createdAt: Date
  var lastUpdated: Date
  var state: ToDoModel.Status
  
}
