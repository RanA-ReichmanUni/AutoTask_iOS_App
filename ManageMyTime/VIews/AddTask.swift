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
   @Environment(\.colorScheme) var colorScheme
    @ObservedObject var taskViewModel:TaskViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
    @State var colorChoise=Color.blue
    @State var alertType=1
    
    var importanceValues = ["Very High", "High", "Medium", "Low","Very Low"]
    
    @State private var selectedImportanceIndex = 2
    
    @State var data: [(String, [String])] = [
        ("Hours", Array(0...20).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    
    @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
    @State var selectedDate = Date()
    
    @State private var isError = false
    @State var notFilledError=false
    
    var disableSave: Bool {
        taskName == "" || (selection[0]=="0" && selection[1]=="0")
    }
    @State private var selectedColorIndex = Color(hex:"#3E59C2")
    //,Color(hex:"#2f8fb5")
    var colorArray = [Color(.systemTeal),Color(hex:"#73C2FB"),Color(hex:"#007FFF"),Color(hex:"#3E59C2"),Color(hex:"#0018F9"),Color(hex:"#AAAAFF"),Color(hex:"#6F6FFF"),Color(hex:"#5B59BA"),Color(hex:"#CC99FF"),Color(hex:"#A54DFF"),Color(hex:"#7F00FF"),Color(hex:"#FFAADF"),Color(hex:"#FF6FC9"),Color(hex:"#FF34B3"),Color(hex:"#EEA7D3"),Color(hex:"#E065B2"),Color(hex:"#CD2990"),Color(hex:"#F19499"),Color.red,Color(hex:"#E64049"),Color(hex:"#B0171F"),Color(hex:"#FBB782"),Color(hex:"#FA9A50"),Color(hex:"#D8570B"),Color(hex:"#80D97E"),Color(hex:"#82B482"),Color(hex:"#3D8B37"),Color(hex:"#8B8989")]
    
  
    
    var body: some View {
        UITableView.appearance().backgroundColor = Color(hex:"#fcfcfc").uiColor()
                  
        return
        VStack(spacing:0) {
            GeometryReader{ geometry in
                Form {
                    Section(header:   HStack {
                                        Image(systemName: "rays").foregroundColor(.green)
                        Text("New Task").font(.system(size: 18)).foregroundColor(.blue)
                        
                    }) {
                        
                        TextField("Task Name", text: self.$taskName)
                    }
                
                     
                 
                            
                       /*   Section {  HStack {        Image(systemName:"exclamationmark.circle").foregroundColor(.blue)
                            Picker(selection: self.$selectedImportanceIndex, label: Text("Importance")) {
                                        ForEach(0 ..< self.importanceValues.count) {
                                            Text(self.importanceValues[$0])
                                          }
                                      }
                                    }
                                  }*/
                            
                        
     
                                            
             
                       
                                     
                            VStack{
              
                                DatePicker(selection: self.$selectedDate, in: Date()... ,label: {
                                    HStack{ Image(systemName:"calendar").foregroundColor(.blue)
                                        Text("Due Date")} })
                                
                            }.animation(.ripple())
                            //Handles IOS 13 date picker animation bug, shame it exsists.
                            
                            
                            Section(header: HStack {
                                     Image(systemName:"clock").foregroundColor(.blue)
                                     Text("Work Time")
                                 }) {
                                    MultiPicker(data: self.data, selection: self.$selection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                              }
                    
                            Section(header: HStack {
                                   Image(systemName:"eyedropper.halffull")
                                   Text("Task Color")
                             }) {
                                 HStack{
                                     Spacer()
                                     Picker(selection: self.$selectedColorIndex, label:Text("")) {
                                               ForEach(self.colorArray ,id:\.self) { color in
                                                Rectangle().fill(color).tag(color)//Tag return a value that we chose to the selected index instead of the default int index. For some reason the default behavior doesn't work here, the int selected index doesn't bind to the choise.
                                               }
                                                                             //.labelsHidden()
                                                                  
                                           }.frame(width: geometry.size.width / 1.4,height:190).pickerStyle(WheelPickerStyle())
                                     Spacer()
                                 }
                                 //.frame(width:800).padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                             }
                       //TextField("Due Date", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    
                    Section(header: HStack {
                                        Image(systemName:"pencil.and.ellipsis.rectangle")
                                        Text("Additional Info")
                                    }) {
                                        TextField("Personal Notes", text: self.$notes)
                                    }
                                    
                       }
                    }

                    
                
            
            
                       /* Toggle(isOn: $activeTask) {
                            Text("Active")
                        }*/
                    
                    
                    
                    
           
                
           
                HStack{
                       Spacer()
                        Button(action: {
                            
                            if(self.disableSave)
                            {
                                 self.isError=true
                                 self.alertType=2
                            }
                            else{
                                do{
                                    try  self.taskViewModel.createTask(taskName: self.taskName, importance: self.importanceValues[self.selectedImportanceIndex], workTimeHours: self.selection[0],workTimeMinutes: self.selection[1], dueDate: self.selectedDate, notes: self.notes,color:self.selectedColorIndex)
                       
                                }
                                 catch DatabaseError.taskCanNotBeScheduledInDue {
                                    self.isError = true
                                    self.alertType=1
                                }
                                catch {
                                           self.isError = true
                                           self.alertType=1
                                       }
                                
                              self.taskViewModel.retrieveAllTasks()
                              self.mode.wrappedValue.dismiss()
                            }

                            }) {
                               
                                Text(" Schedule ").frame(width:100,height:55).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(self.disableSave ? Color.gray : Color.blue).frame(width:100,height:55)).padding(.bottom,20)
                                    
                                
                                
                        } .alert(isPresented: self.$isError) {
                            
                            switch self.alertType{
                            case 1:
                              return Alert(title: Text("Task Can't Be Scheduled"),
                                     message: Text("\nThere is not enough room in your schedule for the new task with this chosen Due Date.\n\nTry making some room or change the Due Date."),
                                     dismissButton: .default(Text("OK")))
                            case 2:
                                return    Alert(title: Text("Missing Required Fields"),
                                          message: Text("\n Task Name, Due Date and Work Time are required fields"),
                                          dismissButton: .default(Text("OK")))
                            default:
                              return Alert(title: Text("Task can not be scheduled"),
                                                               message: Text("\nThere is not enough room in your schedule for the new task in this due.\n\nTry making some room or change the due date."),
                                                               dismissButton: .default(Text("OK")))
                            }
                                        

                           }
                     Spacer()
                      
                    
                    /*Another (more premetive) option for multiple alerts:
                     
                         VStack{//Place holder in order to activate second alert.
                                             Spacer()
                          }  .alert(isPresented: $notFilledError) {
                                   Alert(title: Text("Missing Required Fields"),
                                         message: Text("\n Task name, due date and work time are required fields"),
                                         dismissButton: .default(Text("OK")))

                               }
                     
                     
                     */
        
         
                       
                       // .disabled(disableSave)
                    
             
                }.background(Color(hex:"#fcfcfc"))//.frame(height:30)
           
                    
        }.background(Color(hex:"#fcfcfc"))/*.background(
            self.colorScheme == .dark ? ( LinearGradient(
                gradient: Gradient(colors: [Color("#f1f1f1"),Color("#d1d1d1"),Color("#ffffff"),self.colorChoise]),
                         startPoint: UnitPoint(x: 0.2, y: 0.4),
                         endPoint:.bottom
                       )) :(
            LinearGradient(
            gradient: Gradient(colors: [Color.white,self.colorChoise]),
          startPoint: UnitPoint(x: 0.2, y: 0.4),
          endPoint:.bottom
        )))*/
            
          

             //.navigationBarTitle("Add Task")
           
        }
        
    
}

/*struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
*/
