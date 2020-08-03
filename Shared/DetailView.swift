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
    List{
      ForEach(model.getModelsWithSorting(sorting: sorting)){ model in
        DetailListItem(model: model)
      }.onDelete(perform: { indexSet in
        model.deleteModels(with: indexSet)
      })
    }.listStyle(DefaultListStyle())
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
