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
    
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
  
    var importanceValues = ["Very High", "High", "Medium", "Low","Very Low"]
    
      @State private var selectedImportanceIndex = 2
    
    @State var data: [(String, [String])] = [
        ("One", Array(0...20).map { "\($0)" }),
        ("Two", Array(0...59).map { "\($0)" })
    ]
    @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
    @State var selectedDate = Date()
  
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header:   HStack {
                                        Image(systemName: "pencil")
                                        Text("New Task")
                          }) {
                        
                            TextField("Task Name", text: $taskName)
                          Section {
                                      Picker(selection: $selectedImportanceIndex, label: Text("Importance")) {
                                          ForEach(0 ..< importanceValues.count) {
                                              Text(self.importanceValues[$0])
                                          }
                                      }
                                  }
                       
                        
                
                        NavigationLink(destination: MultiPicker(data: data, selection: $selection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 150)) {
                                              
                                            
                                  Text(verbatim: "Asstimated Work Time:\n \(selection[0]) Hours \(selection[1]) Minutes")
                       
                                              }
                            VStack{
                            DatePicker(selection: $selectedDate, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    
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
                       /* Toggle(isOn: $activeTask) {
                            Text("Active")
                        }*/
                    
                    
                    
                    
                }
                
                HStack {
                    Button(action: {
                        
                          
                           
                        var fixedDate = Date()
                     
                        self.taskViewModel.createTask(taskName: self.taskName, importance: self.importanceValues[self.selectedImportanceIndex], workTimeHours: 5,workTimeMinutes: 30, dueDate: fixedDate, notes: self.notes)
                    
                      
                            /*
                        let newTask = Task(context: self.managedObjectContext)
                            newTask.taskName = self.taskName
                            newTask.importance = self.importanceValues[self.selectedImportanceIndex]
                            newTask.asstimatedWorkTime = 60
                            newTask.dueDate = fixedDate
                            newTask.notes=self.notes
                            newTask.id = UUID()
                            do {
                             try self.managedObjectContext.save()
                             print("Order saved.")
                                print(newTask)
                            } catch {
                             print(error.localizedDescription)
                             }
*/
                    }) {
                                
                        Text("Save")
                    }
                    
                    
                    Button(action: {
         
                        //A couple of calling option with function overload:
                       // try? self.taskController.retrieveTask(taskID : "8F9099DD-1D49-4A27-BFF0-DF1A42AE4D9C")
                        //self.taskViewModel.retrieveTask(taskName: "MVC")
                        //self.taskController.retrieveAllTasks()
                        
                        self.taskViewModel.retrieveTask(taskName: "MVC")
                        
                        
                        /*print(String(self.tasks[1].taskName ?? "none"))
                         print(String(self.tasks[1].importance))
                         print(String(self.tasks[1].asstimatedWorkTime))
                         print(self.tasks[1].notes)
                 */
                    
                        
                                   
                                  }) {
                                              
                                      Text("Retrieve")
                                  }
                    
                    Button(action: {
                          
                       /* self.taskViewModel.updateData(orginalTaskName: "newTaskName", newTaskName: "infi b", newImportance: "VeryHigh", newAsstimatedWorkTime: 50, newDueDate: Date(), newNotes: "Hello")
                     */
                                         
                                                    
                                                   }) {
                                                               
                                                       Text("Update")
                                                   }
                    
                    Button(action: {
                                            
                            self.taskViewModel.deleteTask(taskName: "infi b")
 
                        }) {
                                                                                 
                             Text("Delete")
                            
                            }
                }
                
                
                
                    
            }
            
          

            }
            .navigationBarTitle("Add Task")
        }
        
    
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
