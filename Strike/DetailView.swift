//
//  DetailView.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct DetailView: View {
  
  @EnvironmentObject var model: StrikeModel
  
  var sorting: ContentView.SideBarOptions
  
  var body: some View {
    List(model.getModelsWithSorting(sorting: sorting)){ model in
      DetailListItem(model: model)
        .onTapGesture{
          withAnimation{
            self.model.cycleStatus(with: model.id)
          }
        }
    }.listStyle(SidebarListStyle())
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(sorting: .all)
    }
      .environmentObject(TestModel())
  }
}
