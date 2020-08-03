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
  
  var main: some View {
    ContentView()
      .environmentObject(model)
  }
  
  var body: some Scene {
    WindowGroup {
      #if os(macOS)
      main.frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
      #else
      main
      #endif
    }
  }
}

struct Constants {
  struct Keys {
    static var todoDataKey = "toDoDataKey"
  }
}
