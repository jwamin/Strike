//
//  CalendarView.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct CalendarView: View {
  
  let date = Date()
  
  func getMonth() -> String {
    
    let monthIndex = Calendar.current.component(.month, from: date)
    
    return Calendar.current.monthSymbols[monthIndex-1]
    
    
  }
  
  
  func getDayForWeekday(weekOfMonth:Int, weekday:Int) -> String {
    
    var components = Calendar.current.dateComponents([.weekOfMonth,.month,.day,.weekday,.year,.calendar], from: date)
    
    components.weekOfMonth = weekOfMonth
    components.day = nil
    components.weekday = weekday
    
    if components.isValidDate {
      let validdate = components.date!
      let day = Calendar.current.component(.day, from: validdate)
      return String(day)
    }
    
    return ""
    
  }
  
  var headings = Calendar.current.veryShortStandaloneWeekdaySymbols
  
  var body: some View {
    VStack(alignment:.leading,spacing:3){
      Text(getMonth())
      HStack{
        ForEach(headings,id:\.self) { heading in
          SquareText(str: heading)
        }
      }
      ForEach(0..<6) { week in
        HStack{
          ForEach(1..<8){ weekday -> AnyView in
            let day = Int("\((6*week+(1*week))+weekday)")!
            return AnyView(SquareText(str:"\(getDayForWeekday(weekOfMonth:week+1 ,weekday: weekday))"))
          }
        }
      }
    }.padding()
  }

}

struct SquareText: View {
  let str: String
  var body: some View {
    Text(str).modifier(SquareMod())
  }
}

struct SquareMod: ViewModifier {
  
  func body(content: Content) -> some View {
    content.font(Font.system(.body).smallCaps()).aspectRatio(1, contentMode: .fit).frame(width: 15, height: 15, alignment: .center)
  }
  
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
