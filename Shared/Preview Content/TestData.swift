//
//  TestData.swift
//  Strike
//
//  Created by Joss Manger on 8/3/20.
//

import Foundation

class TestModel: StrikeModel {
  
  override init() {
    super.init()
    
    models = [
      ToDoModel(title: "Move Out Of Brooklyn", description: "Complete The moveout of Brooklyn appartment", createdAt: Date()-3000, lastUpdated: Date(), state:.done),
      ToDoModel(title: "Move Into Dad's", description: "Squat In Greenwich Village. Having said that here is a bit of a long description, who knows where it \ncould go - on and on and on and on and hopefully it will wrap \nbut maybe not...", createdAt: Date()-2000, lastUpdated: Date(), state:.inProgress),
      ToDoModel(title: "Sign Lease In New Appartment", description: "Fond somewhere to live", createdAt: Date()-1000, lastUpdated: Date(), state:.done),
      ToDoModel(title: "Move To Jersey City", description: "Get some movers to schlep your stuff from brooklyn", createdAt: Date(), lastUpdated: Date(), state:.notStarted),
    ]
    
  }
  
}
