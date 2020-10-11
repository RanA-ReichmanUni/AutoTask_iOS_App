//
//  AddRestrictedSpaceUI.swift
//  ManageMyTime
//
//  Created by רן א on 22/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI
import Foundation
import UserNotifications

struct AddRestrictedSpaceUI: View {
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
        ("Hours", Array(0...23).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    
    @State var fromSelection: [String] = [0, 0, 0].map { "\($0)" }
     @State var toSelection: [String] = [0, 0, 0].map { "\($0)" }
    @State var selectedDate = Date()
    
    @State private var isError = false
    @State var notFilledError=false
    
    var dayNameValues = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    @State  var selected: Set<IdentifiableString> = Set(["Sunday"].map { IdentifiableString(string: $0) })
    
   var disableSave: Bool {
        (taskName == "" || (Int(fromSelection[0]) ?? 0 > Int(toSelection[0]) ?? 0 || (Int(fromSelection[0]) ?? 0 == Int(toSelection[0]) ?? 0 && Int(fromSelection[1]) ?? 0 > Int(toSelection[1]) ?? 0) || (Int(fromSelection[0]) ?? 0 == Int(toSelection[0]) ?? 0  && Int(fromSelection[1]) ?? 0 == Int(toSelection[1]) ?? 0))) || selected.isEmpty
    }
    
    @State private var selectedColorIndex = Color(hex:"#3E59C2")
    //,Color(hex:"#2f8fb5")
    var colorArray = [Color(.systemTeal),Color(hex:"#73C2FB"),Color(hex:"#007FFF"),Color(hex:"#3E59C2"),Color(hex:"#0018F9"),Color(hex:"#AAAAFF"),Color(hex:"#6F6FFF"),Color(hex:"#5B59BA"),Color(hex:"#CC99FF"),Color(hex:"#A54DFF"),Color(hex:"#7F00FF"),Color(hex:"#FFAADF"),Color(hex:"#FF6FC9"),Color(hex:"#FF34B3"),Color(hex:"#EEA7D3"),Color(hex:"#E065B2"),Color(hex:"#CD2990"),Color(hex:"#F19499"),Color.red,Color(hex:"#E64049"),Color(hex:"#B0171F"),Color(hex:"#FBB782"),Color(hex:"#FA9A50"),Color(hex:"#D8570B"),Color(hex:"#80D97E"),Color(hex:"#82B482"),Color(hex:"#3D8B37"),Color(hex:"#8B8989")]
    var difficultyValues=[" Difficult "," Average "," Easy "]
   
    
    @State private var selectedDifficultyIndex:Int = 1
    @State private var selectedNotificationIndex:Int = 6
    @Binding var listFlag:Bool
    @Binding var addTaskFlag:Bool
    @State var permissionAqcuired:Bool?
    var loopRang = 0...1
     @State var notificationValues=[""]
    @State var values=0...60
    @State var showPicker=false
    @State var hidePicker=true
    
 
     @State private var selectedDayValuesIndex = 0
    
    private func AutoCollapseNotifications() {
              
                 if(!self.hidePicker)
                {
                     self.hidePicker.toggle()
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.showPicker.toggle()}
                }
             
            }
    
  
    
    var body: some View {
        UITableView.appearance().backgroundColor = (self.colorScheme == .dark ? Color.black : Color(hex:"#fcfcfc")).uiColor()
                  
        return
        VStack(spacing:0) {
            GeometryReader{ geometry in
                 NavigationView{
                Form {
                    
              
                                                   
                                                       
                    Section(header:   HStack {
                                        Image(systemName: "rays").foregroundColor(.green)
                        Text("Repeated Activity").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(.blue)
                        
                    }) {
                        
                        TextField("Activity Name", text: self.$taskName).font(Font.custom("MarkerFelt-Wide", size: 18))
                    }.navigationBarTitle("Add Personal Repeated Activity",displayMode: .inline)
                
                     
                 
                            
                       /*   Section {  HStack {        Image(systemName:"exclamationmark.circle").foregroundColor(.blue)
                            Picker(selection: self.$selectedImportanceIndex, label: Text("Importance")) {
                                        ForEach(0 ..< self.importanceValues.count) {
                                            Text(self.importanceValues[$0])
                                          }
                                      }
                                    }
                                  }*/
                            
                   
                        MultiSelector<Text, IdentifiableString>(
                                                label: Text("In The Following Days: "),
                                                options: self.dayNameValues.map { IdentifiableString(string: $0) },
                                                optionToString: { $0.string },
                                                selected: self.$selected
                                            ).navigationBarTitle("Add Personal Repeated Activity",displayMode: .inline)
                                            
             
                    
                                     
                            
              
                               /* Picker(selection: self.$selectedDayValuesIndex, label: Text("")) {
                                ForEach(0 ..< self.dayNameValues.count) {
                                    Text(" "+self.dayNameValues[$0]+" ").background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).opacity(self.selectedDayValuesIndex==self.dayNameValues.firstIndex(of: self.dayNameValues[$0])  ? 1 : 0)).foregroundColor(self.selectedDayValuesIndex==self.dayNameValues.firstIndex(of: self.dayNameValues[$0]) ? Color.white : Color.blue)
                                   }
                                }*/
                                
                               
                           
                    
                            //Handles IOS 13 date picker animation bug, shame it exsists.
                            Section(header: HStack {
                                   Image(systemName:"eyedropper.halffull")
                                   Text("Activity Color").font(Font.custom("MarkerFelt-Wide", size: 16))
                             }) {
                                 HStack{
                                     Spacer()
                                     Picker(selection: self.$selectedColorIndex, label:Text("")) {
                                               ForEach(self.colorArray ,id:\.self) { color in
                                                Rectangle().fill(color).tag(color)//Tag return a value that we chose to the selected index instead of the default int index. For some reason the default behavior doesn't work here, the int selected index doesn't bind to the choise.
                                               }
                                                                             //.labelsHidden()
                                                                  
                                     }.frame(width: geometry.size.width / 5,height:190).pickerStyle(WheelPickerStyle()).animation(.default)
                                     Spacer()
                                 }
                                 //.frame(width:800).padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                             }
                            
                            Section(header: HStack {
                                     Image(systemName:"clock").foregroundColor(.blue)
                                     Text("From Hour: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                                 }) {
                                    MultiPicker(data: self.data, selection: self.$fromSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                              }.navigationBarTitle("Add Personal Repeated Activity",displayMode: .inline)
                            
                    
                            Section(header: HStack {
                                      Image(systemName:"clock").foregroundColor(.blue)
                                      Text("To Hour: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                                  }) {
                                     MultiPicker(data: self.data, selection: self.$toSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()
                               }
                          
                    
                 
                    
                            Section(header: HStack {
                                    Image(systemName:"chart.bar")
                                Text("Difficulty").font(Font.custom("MarkerFelt-Wide", size: 16))
                              }) {
                                  HStack{
                                      Spacer()
                                      Picker(selection: self.$selectedDifficultyIndex, label:Text("")) {
                                                ForEach(self.difficultyValues ,id:\.self) { element in
                                                    Text(element).font(Font.custom("MarkerFelt-Wide", size: 30)).tag(Int(self.difficultyValues.firstIndex(of: element)!))
                                                }
                                                                              //.labelsHidden()
                                                                   
                                      }.frame(width: geometry.size.width / 5,height:140).pickerStyle(WheelPickerStyle()).animation(.default)
                                      Spacer()
                                  }
                                  //.frame(width:800).padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                              }.navigationBarTitle("Add Personal Repeated Activity",displayMode: .inline)
                    
               
                                    
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
                                    
                                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                                self.permissionAqcuired=success
                                            DispatchQueue.main.async {
                                            
                                            if self.permissionAqcuired ?? false {
                                                        do{
                                                            try  self.taskViewModel.createTask(taskName: self.taskName, importance: self.importanceValues[self.selectedImportanceIndex], workTimeHours: self.fromSelection[0],workTimeMinutes: self.fromSelection[1], dueDate: self.selectedDate, notes: self.notes,color:self.selectedColorIndex,difficultyIndex: self.selectedDifficultyIndex,notificationIndex:self.selectedNotificationIndex)
                                                              
                                                                  self.taskViewModel.UpdateAllTasks()
                                                                  self.addTaskFlag=false
                                                                  self.listFlag=true
                                                          
                                                                  self.mode.wrappedValue.dismiss()
                                                 
                                                          }
                                                           catch DatabaseError.taskCanNotBeScheduledInDue {
                                                              self.isError = true
                                                              self.alertType=1
                                                              
                                                          }
                                                          catch {
                                                             self.isError = true
                                                             self.alertType=1
                                                         }
                                                        
                                            } else if !(self.permissionAqcuired ?? true){
                                                
                                                       
                                                        self.isError = true
                                                        self.alertType=3
                                                    }
                                             
                                          
                                        }
                            
                                }
                              
                                  
                                                                
                                  
                        
                         
                            }

                            }) {
                               
                                Text(" Add ").frame(width:100,height:55).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(self.disableSave ? Color(hex:"#595858") : Color.blue).frame(width:100,height:55)).padding(.bottom,20)
                                    
                                
                                
                        } .alert(isPresented: self.$isError) {
                            
                            switch self.alertType{
                            case 1:
                              return Alert(title: Text("Task Can't Be Scheduled"),
                                     message: Text("\nThere is not enough room in your schedule for the new task with this chosen Due Date.\n\nTry making some room or change the Due Date."),
                                     dismissButton: .default(Text("OK")))
                            case 2:
                                return    Alert(title: Text("Missing Required Fields"),
                                          message: Text("\n Task Name, Work Hours (From and To), and Days are required fields.\n\n'From Hour' field should be smaller then 'To Hour' field"),
                                          dismissButton: .default(Text("OK")))
                            case 3:
                                
                                 return Alert(title: Text("Missing Required Premissions"), message: Text("Manage My Time Needs A premission To Present Notifications In Order For It to Update You on Upcoming Assigments"), primaryButton: .destructive(Text("Ok, Send Me To Notification Settings")) {
                                                                            
                                              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                            
                                              //  self.permissionAqcuired=nil
                                                
                                        
                                      
                                   
                                  }, secondaryButton: .cancel())
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
                    
             
                }.background( (self.colorScheme == .dark ? Color(hex:"#212121") : Color(hex:"#fcfcfc")))//.frame(height:30)
           
                    
        }.background(Color(hex:"#fcfcfc"))
        /*.background(
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

/*struct AddRestrictedSpaceUI_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
*/


struct MultiSelector<LabelView: View, Selectable: Identifiable & Hashable>: View {
    let label: LabelView
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    var selected: Binding<Set<Selectable>>

    private var formattedSelectedListString: String {
        ListFormatter.localizedString(byJoining: selected.wrappedValue.map { optionToString($0) })
    }

    var body: some View {
        NavigationLink(destination: multiSelectionView()) {
            HStack {
                label
                Spacer()
                Text(formattedSelectedListString)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }

    private func multiSelectionView() -> some View {
        MultiSelectionView(
            options: options,
            optionToString: optionToString,
            selected: selected
        )
    }
}
