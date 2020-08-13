//
//  DetailedTaskUI.swift
//  ManageMyTime
//
//  Created by רן א on 10/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DetailedTaskUI: View {
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var taskViewModel:TaskViewModel
    @State private var showingAlert = false

    
         var taskName : String
    var importance : String
    
      var dueDate : Date
      var notes :String
      var asstimatedWorkTimeHour : Int
      var asstimatedWorkTimeMinutes : Int
      var startTimeHour:Int
      var startTimeMinutes:Int
      var endTimeHour:Int
      var endTimeMinutes:Int
      var day:Int
      var month:Int
      var year:Int
      
      var taskId:UUID
    
      var color: Color
    
    var body: some View {
         
        VStack(){
            
        DetailedTask(taskName: taskName, importance: importance, dueDate: dueDate, notes: notes, asstimatedWorkTimeHour: asstimatedWorkTimeHour, asstimatedWorkTimeMinutes: asstimatedWorkTimeMinutes, startTimeHour: startTimeHour, startTimeMinutes: startTimeMinutes, endTimeHour: endTimeHour, endTimeMinutes: endTimeMinutes, day: day, month: month, year: year, taskId: taskId, color: color)
        
         
            
          HStack{
            Spacer()
              Button(action: {
                                                      
                   
                                                                                
                           }) {
                            
                              VStack{  Image(systemName: "pencil").foregroundColor(Color.black)
                                Text("Edit Task").foregroundColor(Color.black)}.padding()
                                                           
                                                           
             }
              
           
              
              Button(action: {
                               
         
                    self.showingAlert = true
                                                         
                            }) {
                              VStack{
                               Image(systemName: "trash").foregroundColor(Color.black)
                                Text("Delete").foregroundColor(Color.black)}.padding()
                                                            
                                                            
              } .alert(isPresented:$showingAlert) {
                         Alert(title: Text("Are you sure you want to delete this task ?"), message: Text("You can`t undo this action"), primaryButton: .destructive(Text("Delete")) {
                                      self.taskViewModel.deleteTask(taskId: self.taskId)

                                          self.mode.wrappedValue.dismiss()
                            }, secondaryButton: .cancel())}
            Spacer()
          
           
          }.padding().background(self.color.opacity(0)).clipShape(RoundedRectangle(cornerRadius: 15))
            
        }.background(LinearGradient(
            gradient: Gradient(colors: [.white,self.color,.white]),
          startPoint: UnitPoint(x: 0.2, y: 0.2),
          endPoint:.bottomLeading
        ))
    }
}

/*struct DetailedTaskUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTaskUI()
    }
}
*/
