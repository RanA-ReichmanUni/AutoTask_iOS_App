//
//  AddRestrictedSpace.swift
//  ManageMyTime
//
//  Created by רן א on 20/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI
import Foundation

struct AddRestrictedSpace: View {

    
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
  
    var importanceValues = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    @State private var selectedImportanceIndex = 0
    
    @State var data: [(String, [String])] = [
        ("Hours", Array(0...20).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    @State var fromSelection: [String] = [0, 0, 0].map { "\($0)" }
     @State var toSelection: [String] = [0, 0, 0].map { "\($0)" }
    @State var selectedDate = Date()
  
   var disableSave: Bool {
        taskName == "" || (fromSelection[0]=="0" && fromSelection[1]=="0") || (toSelection[0]=="0" && toSelection[1]=="0")
    }
    
    var body: some View {
        
      //  NavigationView {
        GeometryReader{ geometry in
        ScrollView{
          
            VStack {
               // Form {
                  Spacer()
                  Spacer()
                  Spacer()
                    Section(header:   HStack {
                        
                                        Image(systemName: "rays").foregroundColor(.green)
                        
                        Text("New Occupied Space").font(.system(size: 18)).foregroundColor(.blue)
                        
                          }) {
                            HStack{
                                Spacer()
                                TextField("Activity Name (Optional)", text: self.$taskName).frame(width:200).background(Color(hex:"#f0fffd"))
                            Spacer()
                            }
                            Section {  HStack {
                               
                        Image(systemName:"calendar").foregroundColor(.blue).padding(.leading,5)
                                Text("Day")
                                Picker(selection: self.$selectedImportanceIndex, label: Text("")) {
                                    ForEach(0 ..< self.importanceValues.count) {
                                         Text(self.importanceValues[$0])
                                       }
                                   }.pickerStyle(WheelPickerStyle())
                                 }.background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                               }
                            
                                Section(header: HStack {
                                    Spacer()
                                    
                               
                                                        Text("From")
                                    Spacer()
                                                    }) {
                                                        MultiPicker(data: self.data, selection: self.$fromSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding() .frame(width:geometry.size.width-3,height:190).background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                                }
                          
                            
                          
                            Section(header: HStack {
                                 Spacer()
                             
                                                                          Text("To")
                                            Spacer()                           }) {
                                                MultiPicker(data: self.data, selection: self.$toSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding() .frame(width:geometry.size.width-3,height:190).background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                            }
                         
   
                    
                    }
                    
             
                    
                    
                    
                    
                
                
           
                
                        Button(action: {
                            
               
                           
                         
                           /* self.taskViewModel.createTask(taskName: self.taskName, importance: self.importanceValues[self.selectedImportanceIndex], workTimeHours: self.fromSelection[0],workTimeMinutes: self.fromSelection[1], dueDate: self.selectedDate, notes: self.notes)*/
                        
                          self.mode.wrappedValue.dismiss()
               

                            }) {
                                    
                            Text("Save")
                        }
                        .disabled(self.disableSave).padding()
                    
            }
        }
        }.background(    LinearGradient(
            gradient: Gradient(colors: [Color(hex:"#f0f1f2"),Color(hex:"#f0f1f2")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                         //self.color,.purple,.purple,.purple
                            startPoint: .topLeading,
                          endPoint:.bottomTrailing
                        ))
                    
          //  }
            
          

          //  }.navigationBarTitle("Add Task")
        }
        
    
}

struct AddRestrictedSpace_Previews: PreviewProvider {
    static var previews: some View {
        AddRestrictedSpace()
    }
}
