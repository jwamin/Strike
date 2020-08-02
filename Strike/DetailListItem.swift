//
//  DetailListItem.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct DetailListItem: View {
  
  let model: ToDoModel
  @State var expanded: Bool = false
  
  var imageName: String {
    switch model.state {
    case .done:
      return "circle.fill"
    case .inProgress:
      return "circle.lefthalf.fill"
    default:
      return "circle"
    }
  }
  
    var body: some View {
      
      VStack(alignment: .leading){
        HStack(alignment:.top){
        Label(model.title, systemImage: imageName)
          Spacer()
          Button(action: {
            withAnimation{
                  self.expanded.toggle()
            }
            
          }, label: {
            Image(systemName: "info.circle")
          })
        }
        if expanded {
          Text(model.description).font(Font.system(.body).smallCaps())
          .strikethrough(model.state == .done)
        }
        Spacer()
      }
    }
}

struct DetailListItem_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        DetailListItem(model: TestModel().models.first!)
        DetailListItem(model: TestModel().models[1])
        DetailListItem(model: TestModel().models[3])
      }
    }
}
