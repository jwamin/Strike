//
//  StrikeApp.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

@main
struct StrikeApp: App {
  
  @StateObject private var model: StrikeModel = StrikeModel()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(model)
              .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        }
    }
}

struct Constants {
  struct Keys {
    static var todoDataKey = "toDoDataKey"
  }
}
