//
//  TodoModel.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import Foundation

class StrikeModel: ObservableObject {
  
  @Published var models: [ToDoModel] = []
  
  private var arrangedObjects: [ToDoModel] = []
  
  
  private var decoder = JSONDecoder()
  
  init(){
    
    let data = UserDefaults.standard.data(forKey: Constants.Keys.todoDataKey) ?? Data()
    
    let models = (try? decoder.decode([ToDoModel].self, from: data)) ?? []
    
    self.models = models
    
    self.arrangedObjects = models
    
  }
  
  // MARK: Update Status of Item
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
  
  //MARK: Process Models for display
  
  func getModelsWithSorting(sorting:ContentView.SideBarOptions) -> [ToDoModel] {
    
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
    case .notStarted:
      returnArray = models.filter({ (model) -> Bool in
        model.state == .notStarted
      })
    }
    
    self.arrangedObjects = returnArray.sorted(by: {
      $0.lastUpdated>$1.lastUpdated
    })
    
    return arrangedObjects
    
  }
  
  //MARK: CRUD
  
  func addModel(with title:String, and description:String){
    models.append(ToDoModel(title: title, description: description))
    saveModels()
  }
  
  func deleteModels(with set:IndexSet){
    let ids = arrangedObjects.enumerated().compactMap { (index,model) -> UUID? in
      if set.contains(index){
        return model.id
      }
      return nil
    }
    
    // use half stable partition
    
    models.removeAll {
      ids.contains($0.id)
    }
    
    saveModels()
    
  }
  
  func saveModels(){
    let encoder = JSONEncoder()
    let data = try! encoder.encode(models)
    
    UserDefaults.standard.setValue(data, forKey: Constants.Keys.todoDataKey)
  }
  
}
