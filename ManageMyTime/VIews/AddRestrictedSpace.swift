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

    
    @ObservedObject var restrictedSpaceViewModel = RestrictedSpaceViewModel()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var activeTask : Bool = true
    @State var taskName : String = ""
    @State var notes : String = ""
    @State var isError=false
    var dayNameValues = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    @State private var selectedDayValuesIndex = 0
    
    @State var data: [(String, [String])] = [
        ("Hour", Array(0...23).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    @State var fromSelection: [String] = [0, 0, 0].map { "\($0)" }
     @State var toSelection: [String] = [0, 0, 0].map { "\($0)" }
    @State var selectedDate = Date()
  
   var disableSave: Bool {
         (fromSelection[0]=="0" && fromSelection[1]=="0") || (toSelection[0]=="0" && toSelection[1]=="0")
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
                                TextField("Activity Name (Optional)", text: self.$taskName).frame(width:200).background(Color.white)
                            Spacer()
                            }
                            Section(header: HStack {
                                Image(systemName:"calendar").foregroundColor(.blue).padding(.leading,5)
                                 Text("Day")
                                
                            })
                            {
                            VStack {
                               
                               
                                Picker(selection: self.$selectedDayValuesIndex, label: Text("")) {
                                    ForEach(0 ..< self.dayNameValues.count) {
                                         Text(self.dayNameValues[$0])
                                       }
                                }.frame(height: 110).padding() .frame(width: geometry.size.width / 2.5,height:190).pickerStyle(WheelPickerStyle()).clipped()
                            }.background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                }
                            Spacer()
                            
                                Section(header: HStack {
                                   
                                    
                               
                                   Image(systemName:"clock")
                                    .foregroundColor(.blue).padding(.leading,5)
                                    
                                    Text("Starts From")
                                    Spacer()
                                                    }) {
                                                        MultiPicker(data: self.data, selection: self.$fromSelection,stringValue1: "Hour",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding() .frame(width:geometry.size.width/1.5,height:190).background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                                }
                          
                            
                          
                            Section(header: HStack {
                                
                             
                                                                          Image(systemName:"clock")
                                                                                                       .foregroundColor(.blue).padding(.leading,5)
                                            Text("Ends In")
                                
                                            Spacer()                           }) {
                                                MultiPicker(data: self.data, selection: self.$toSelection,stringValue1: "Hour",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding() .frame(width:geometry.size.width/1.5,height:190).background(RoundedRectangle(cornerRadius: 40).fill(Color.white))
                            }
                         
   
                    
                    }
                    
             
                    
                    
                    
                    
                
                
           
                
                        Button(action: {
                            
               
                           
                         
         
                        
                            do{
                                try self.restrictedSpaceViewModel.CreateRestrictedSpace(startTimeHour: self.fromSelection[0], startTimeMinutes: self.fromSelection[1] , endTimeHour: self.toSelection[0], endTimeMinutes: self.toSelection[1] , dayOfTheWeek: self.dayNameValues[self.selectedDayValuesIndex])
                            }
                            catch RestrictedSpaceError.alreadyScheduled{
                                
                                self.isError=true
                            }
                            catch {
                                 
                                self.isError=true
                             }
                            
                          //self.mode.wrappedValue.dismiss()
               

                            }) {
                                    
                            Text("Save")
                        } .disabled(self.disableSave).alert(isPresented: self.$isError) {
                        Alert(title: Text("Already Occupied"),
                              message: Text("\n You already added an activity for that day and time slot"),
                              dismissButton: .default(Text("OK")))}
                            .padding()
                      
                    
            }
        }
        }.background(    LinearGradient(
            gradient: Gradient(colors: [Color(hex:"#fcfcfc"),Color(hex:"#fcfcfc")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
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
