//
//  ImageSwitchView.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct ImageSwitchView: View {
  
  var state: ToDoModel.Status
  
  func positionY(y: CGFloat) -> CGFloat {
    switch state {
    case .inProgress:
      return 0
    case .done:
      return y
    case .notStarted:
      return -y
    }
  }
  
  
    var body: some View {
      GeometryReader { reader in
        Image("circle").resizable().aspectRatio(1, contentMode: .fill).opacity(0).background(
        HStack(spacing:0){
          Image(systemName: "circle.fill").resizable().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
          Image(systemName: "circle.lefthalf.fill").resizable().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
          Image(systemName: "circle").resizable().aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        }.offset(x: positionY(y: reader.size.width))
        )
      }
    }
}

struct ImageSwitchView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ImageSwitchView(state: .done).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).aspectRatio(1, contentMode: .fill)
        ImageSwitchView(state: .inProgress).frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).aspectRatio(1, contentMode: .fill)
        ImageSwitchView(state: .notStarted).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).aspectRatio(1, contentMode: .fill)
      }
    }
}

