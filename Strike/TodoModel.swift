//
//  TodoModel.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import Foundation

class StrikeModel: ObservableObject {
  
  @Published var models: [ToDoModel] = []
  
  func cycleStatus(with id:UUID){
    
    let modelIndex = models.firstIndex { (model) in
      model.id == id
    }
    
    if let validIndex = modelIndex {
      nextStatus(index: validIndex)
    }
    
  }
  
  private func nextStatus(index:Int){
    let currentStatus = models[index].state
    var nextStatus: ToDoModel.Status = currentStatus
    
    switch(currentStatus){
    case .notStarted:
      nextStatus = .inProgress
    case .inProgress:
      nextStatus = .done
    case .done:
      nextStatus = .notStarted
    }
    
    models[index].state = nextStatus
    models[index].lastUpdated = Date()
    
    saveModels()
    
  }
  
  func getModelsWithSorting(sorting:ContentView.SideBarOptions) -> [ToDoModel]{
    
    var returnArray = Array<ToDoModel>()
    
    switch(sorting){
    
    case.all:
      returnArray = models
    case .done:
      returnArray = models.filter({ (model) -> Bool in
        model.state == .done
      })
    case .progress:
      returnArray = models.filter({ (model) -> Bool in
        model.state == .inProgress
      })
    
    }
    
    return returnArray.sorted(by: {
      $0.lastUpdated>$1.lastUpdated
    })
    
  }
  
  func addModel(with title:String, and description:String){
    models.append(ToDoModel(title: title, description: description))
    saveModels()
  }
  
  private var decoder = JSONDecoder()
  
  init(){
    
    let data = UserDefaults.standard.data(forKey: Constants.Keys.todoDataKey) ?? Data()
    
    let models = (try? decoder.decode([ToDoModel].self, from: data)) ?? []
    
    self.models = models
    
  }
  
  func saveModels(){
    let encoder = JSONEncoder()
    let data = try! encoder.encode(models)
    
    UserDefaults.standard.setValue(data, forKey: Constants.Keys.todoDataKey)
  }
  
}

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


class TestModel: StrikeModel {
  
  override init() {
    super.init()
    
    models = [
      ToDoModel(title: "Move Out Of Brooklyn", description: "Complete The moveout of Brooklyn appartment", createdAt: Date()-3000, lastUpdated: Date(), state:.done),
      ToDoModel(title: "Move Into Dad's", description: "Squat In Greenwich Village", createdAt: Date()-2000, lastUpdated: Date(), state:.inProgress),
      ToDoModel(title: "Sign Lease In New Appartment", description: "Fond somewhere to live", createdAt: Date()-1000, lastUpdated: Date(), state:.done),
      ToDoModel(title: "Move To Jersey City", description: "Get some movers to schlep your stuff from brooklyn", createdAt: Date(), lastUpdated: Date(), state:.notStarted),
    ]
    
  }
  
  
}
