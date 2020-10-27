//
//  DayEndStartView.swift
//  ManageMyTime
//
//  Created by רן א on 12/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DayBoundsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State var data: [(String, [String])] = [
        ("Hours", Array(1...23).map { "\($0)" }),
        ("Minutes", Array(0...59).map { "\($0)" })
    ]
    @ObservedObject  var taskViewModel:TaskViewModel
    
     @Binding var fromSelection: [String]
    @Binding var toSelection: [String]
    @Binding var showAlert:Bool
    @Binding var alertType:Int
    
    var disableSave: Bool {
           ((Int(fromSelection[0]) ?? 0 > Int(toSelection[0]) ?? 0 || (Int(fromSelection[0]) ?? 0 == Int(toSelection[0]) ?? 0 && Int(fromSelection[1]) ?? 0 > Int(toSelection[1]) ?? 0) || (Int(fromSelection[0]) ?? 0 == Int(toSelection[0]) ?? 0  && Int(fromSelection[1]) ?? 0 == Int(toSelection[1]) ?? 0))) 
       }
    
    @State private var isError = false
    
    var body: some View {
        
        UITableView.appearance().backgroundColor = self.colorScheme == .dark ? Color.black.uiColor() : Color.white.uiColor()
                   return
        VStack{
            
            RoundedRectangle(cornerRadius: 20).frame(height:60).isHidden(true)
        Form{
          
    
            
               
                Section(header: HStack {
                        Image(systemName:"clock").foregroundColor(.blue)
                        Text("Day Starts At: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                        Spacer()
                    }) {
                        MultiPicker(data: self.data, selection: self.$fromSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding().background(RoundedRectangle(cornerRadius: 20).fill((self.colorScheme == .dark ? Color(hex:"#303030") : Color(hex:"#f9f9f9")).opacity(0.9)))
                }.padding()
                                           
                
               Section(header: HStack {
                         Image(systemName:"clock").foregroundColor(.blue)
                         Text("Day Ends In: ").font(Font.custom("MarkerFelt-Wide", size: 16))
                        Spacer()
                     }) {
                        MultiPicker(data: self.data, selection: self.$toSelection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding().background(RoundedRectangle(cornerRadius: 20).fill((self.colorScheme == .dark ?  Color(hex:"#303030") : Color(hex:"#f9f9f9")).opacity(0.9)))
               }.padding()
         
            
            
           
           
        }.background(self.colorScheme == .dark ? Color.black : Color.white .opacity(0.1))
            .navigationBarTitle("Set Day Bounds For Auto Scheduling", displayMode: .inline)
      
        
       
        HStack{
               Spacer()
                Button(action: {
                    
                      if(self.disableSave)
                     {
                          self.isError=true
                          
                     }
                     else{
                        
                        self.taskViewModel.UpdateStartEndDay(dayStartTimeHour: self.fromSelection[0], dayStartTimeMinutes:  self.fromSelection[1], dayEndTimeHour:  self.toSelection[0], dayEndTimeMinutes:  self.toSelection[1])
                        
                        self.alertType=2
                        self.showAlert=true
                        
                        self.mode.wrappedValue.dismiss()
                        
                        
                    }

                    }) {
                       
                        Text(" Save ").frame(width:100,height:55).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(self.disableSave ? Color(hex:"#595858") : Color.blue).frame(width:100,height:55)).padding(.bottom,20)
                            
                        
                        
                } .alert(isPresented: self.$isError) {
                    
              
                      return Alert(title: Text("Incorrect Settings"),
                                                       message: Text("\n 'Starts At' Time Must Be Smaller Then 'Ends In' Time"),
                                                       dismissButton: .default(Text("OK")))
                    }
                                
                Spacer()
                   }
            
              
        }
      
        
        
    }
}

/*struct DayEndStartView_Previews: PreviewProvider {
    static var previews: some View {
        DayEndStartView()
    }
}*/
