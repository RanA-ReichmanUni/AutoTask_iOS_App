//
//  AddTask.swift
//  ManageMyTime
//
//  Created by רן א on 22/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct AddTask: View {
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
  
    var importanceValues = ["Very High", "High", "Medium", "Low","Very Low"]
    
      @State private var selectedImportanceIndex = 2
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("New Task")) {
                    TextField("Task Name", text: $taskName)
                      Section {
                                  Picker(selection: $selectedImportanceIndex, label: Text("Importance")) {
                                      ForEach(0 ..< importanceValues.count) {
                                          Text(self.importanceValues[$0])
                                      }
                                  }
                              }
                    TextField("Due Date", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    TextField("Asstimated Work Time", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                 
                }
                
                Section(header: Text("Additional Info")) {
                    TextField("Notes", text: $notes)
                }
                    Toggle(isOn: $activeTask) {
                        Text("Active")
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
        
    
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
