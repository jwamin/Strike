//
//  DetailListItem.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct DetailListItem: View {
  
  @EnvironmentObject var mainModel: StrikeModel
  
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
    
    
    HStack(alignment:.firstTextBaseline){
      Group {
        Image(systemName: imageName).animation(.default)
        VStack(alignment:.leading){
          Text(model.title)
            .font(.title3)
            .bold()
            .strikethrough(model.state == .done).animation(.default)
          if expanded {
            Text(model.description)
              .strikethrough(model.state == .done)
              .lineLimit(nil)
              .multilineTextAlignment(.leading)
              .font(Font.system(.body).smallCaps()).padding()
              .frame(maxHeight:.infinity).animation(.default).zIndex(1)
          }
        }
      }.onTapGesture{
        withAnimation{
          self.expanded = false
          self.mainModel.cycleStatus(with: model.id)
        }
      }
      Spacer()
      Button(action: {
        withAnimation {
          self.expanded.toggle()
        }
      }, label: {
        Image(systemName:"info.circle")
      }).foregroundColor(expanded ? Color.red : nil)
    }.frame(maxWidth:.infinity)
  }
}

struct DetailListItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DetailListItem(model: TestModel().models.first!)
      DetailListItem(model: TestModel().models[1],expanded: true)
      DetailListItem(model: TestModel().models[3])
    }
  }
}
