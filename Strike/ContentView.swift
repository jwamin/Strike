//
//  ContentView.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject private var model: StrikeModel
  
  enum SideBarOptions {
    case all
    case done
    case progress
    case notStarted
  }
  
  @State var selection: Set<SideBarOptions> = [.all] {
    willSet{
      print(newValue)
    }
    didSet {
      print(selection)
    }
  }
  
  var sidebar: some View {
    
    List(selection: $selection){
      
      Section {
        SideBarOption(title: "All", iconName: "circles.hexagonpath", option: SideBarOptions.all)
      }

      Divider()

      Section {
        Text("Sorting Options")
        SideBarOption(title: "Not Started", iconName: "circle", option: SideBarOptions.notStarted)
        
        SideBarOption(title: "In Progress", iconName: "circle.lefthalf.fill", option: SideBarOptions.progress)
        
        SideBarOption(title: "Done", iconName: "circle.fill", option: .done)
        
      }
      
  
    }.listStyle(SidebarListStyle())
    
  }
  
  @State var showAddScreen: Bool = false
  
  var body: some View {
    NavigationView{
      sidebar
      DetailView(sorting: $selection.wrappedValue.first!)
        .toolbar(items: {
          ToolbarItem(placement: .primaryAction){
            Button(action: {
              showAddScreen.toggle()
            }, label: {
              Label("Add", systemImage: "plus").font(.largeTitle)
            })
          }
          ToolbarItem(placement: .navigation) {
            Button(action: toggleSidebar, label: {
              Image(systemName: "sidebar.left")
            })
          }
        })
    }.sheet(isPresented: $showAddScreen, onDismiss: nil, content: {
      AddForm()
        .environmentObject(model)
    })
  }
}

private func toggleSidebar() {
      #if os(iOS)
      #else
      NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
      #endif
  }

struct SideBarOption: View {
  
  var title: String
  var iconName: String
  var option: ContentView.SideBarOptions
  
  var body: some View {
    Label(title, systemImage: iconName)
      .tag(option)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
