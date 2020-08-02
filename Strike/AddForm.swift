//
//  AddForm.swift
//  Strike
//
//  Created by Joss Manger on 8/2/20.
//

import SwiftUI

struct AddForm: View {
  
  @EnvironmentObject var model: StrikeModel
  @Environment(\.presentationMode) var presentationMode
  
  @State var title: String = ""
  @State var description: String = ""
  
    var body: some View {
      Form{
        Section{
          Text("Add A Task").font(.largeTitle)
          TextField("Title", text: $title).textFieldStyle(DefaultTextFieldStyle())
          TextField("Description", text: $description).textFieldStyle(DefaultTextFieldStyle())
        }.frame(minWidth:300)
        Section{
          Button("Submit") {
            withAnimation {
              self.model.addModel(with: title, and: description)
              self.presentationMode.wrappedValue.dismiss()
            }
          }
        }
      }.padding()
    }
}

struct AddForm_Previews: PreviewProvider {
    static var previews: some View {
        AddForm()
    }
}
