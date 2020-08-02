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
  
  #if os(macOS)
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
  #else
  var sidebar: some View {
    
    List(selection: $selection){
      
      Section {
        Text("Sorting Options")
        SideBarOption(title: "All", iconName: "circles.hexagonpath", option: SideBarOptions.all,showAddScreen:$showAddScreen)
        
        SideBarOption(title: "Not Started", iconName: "circle", option: SideBarOptions.notStarted,showAddScreen:$showAddScreen)
        
        SideBarOption(title: "In Progress", iconName: "circle.lefthalf.fill", option: SideBarOptions.progress,showAddScreen:$showAddScreen)
        
        SideBarOption(title: "Done", iconName: "circle.fill", option: .done,showAddScreen:$showAddScreen)
      }
      
      
    }.listStyle(SidebarListStyle())
    
  }
  #endif
  
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
  @Binding var showAddScreen: Bool
  
  var body: some View {
    #if os(macOS)
    Label(title, systemImage: iconName)
      .tag(option)
    #else
    NavigationLink(
      destination: DetailView(sorting: option).navigationBarItems(trailing: Button(action: {
        showAddScreen.toggle()
      }, label: {
        Label("Add", systemImage: "plus")
      })),
      label: {
        Label(title, systemImage: iconName)
          .tag(option)
      })
    
    #endif
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
