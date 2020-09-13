//
//  AddTask.swift
//  ManageMyTime
//
//  Created by רן א on 22/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI
import Foundation

struct AddTask: View {
    /*
   @Environment(\.managedObjectContext) var managedObjectContext
              
            @FetchRequest(
                  entity: Task.entity(),
                  sortDescriptors: [
                      NSSortDescriptor(keyPath: \Task.taskName, ascending: true)
                  ]
              ) var tasks: FetchedResults<Task>
    */
    
    //var taskViewModel = TaskViewModel()
  
    @ObservedObject var taskViewModel:TaskViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
    @State var colorChoise=Color.blue
    
    var importanceValues = ["Very High", "High", "Medium", "Low","Very Low"]
    
    @State private var selectedImportanceIndex = 2
    
    @State var data: [(String, [String])] = [
        ("Hours", Array(0...20).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
    @State var selectedDate = Date()
    
    @State private var isError = false
    
   var disableSave: Bool {
        taskName == "" || (selection[0]=="0" && selection[1]=="0")
    }
    
    var body: some View {
        
        NavigationView {
        VStack(spacing:0) {
                Form {
                    Section(header:   HStack {
                                        Image(systemName: "rays").foregroundColor(.green)
                        Text("New Task").font(.system(size: 18)).foregroundColor(.blue)
                        
                          }) {
                        
                            TextField("Task Name", text: $taskName)
                            
                        Section(header: HStack {
                                                Image(systemName:"clock").foregroundColor(.blue)
                                                Text("Work Time")
                                            }) {
                                         MultiPicker(data: data, selection: $selection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                                         }
                            
                          Section {  HStack {        Image(systemName:"exclamationmark.circle").foregroundColor(.blue)
                                      Picker(selection: $selectedImportanceIndex, label: Text("Importance")) {
                                          ForEach(0 ..< importanceValues.count) {
                                            Text(self.importanceValues[$0])
                                          }
                                      }
                                    }
                                  }
                            
                        
     
                                            
             
                       
                                     
                            VStack{
              
                            DatePicker(selection: $selectedDate, in: Date()... ,label: {
                                    HStack{ Image(systemName:"calendar").foregroundColor(.blue)
                                        Text("Due Date")} })
                                
                            }.animation(nil)
                            //Handles IOS 13 date picker animation bug, shame it exsists.
                            
                            
                       //TextField("Due Date", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                            
                    }
                    
                    Section(header: HStack {
                        Image(systemName:"pencil.and.ellipsis.rectangle")
                        Text("Additional Info")
                    }) {
                        TextField("Notes", text: $notes)
                    }
                    
                    NavigationLink(destination:ColorPicker(colorChoise:self.$colorChoise)){
                                              HStack{
                                                  Text("Color Picker")
                                                  
                                                  Spacer()
                                               // RoundedRectangle(cornerRadius: 20).isHidden(true)
                                               
                                                RoundedRectangle(cornerRadius: 20).fill(self.colorChoise)
                                                 Spacer()
                                              }
                                           
                                    }
                       /* Toggle(isOn: $activeTask) {
                            Text("Active")
                        }*/
                    
                    
                    
                    
             }
                
           
                HStack{
                       Spacer()
                        Button(action: {
                            
               
                           
                            do{
                                try  self.taskViewModel.createTask(taskName: self.taskName, importance: self.importanceValues[self.selectedImportanceIndex], workTimeHours: self.selection[0],workTimeMinutes: self.selection[1], dueDate: self.selectedDate, notes: self.notes,color:self.colorChoise)
                            }
                             catch DatabaseError.taskCanNotBeScheduledInDue {
                                self.isError = true
                            }
                            catch {
                                       self.isError = true
                                   }
                            
                          self.taskViewModel.retrieveAllTasks()
                          self.mode.wrappedValue.dismiss()
               

                            }) {
                                    
                            Text("Schedule")
                        } .alert(isPresented: $isError) {
                               Alert(title: Text("Task can not be scheduled"),
                                     message: Text("\nThere is not enough room in your schedule for the new task.\n\nTry making some room or change the due date."),
                                     dismissButton: .default(Text("OK")))

                           }
                        .disabled(disableSave)
                    
              Spacer()
                }.background(Color.white).frame(height:30)
                
                    
        }
            
          

            }//.navigationBarTitle("Add Task")
        }
        
    
}

/*struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
*/
