//
//  ScheduleViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DailyView: View {
    
    
    var timeChar = "25"
    //var columns : [String]
    //@Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var taskViewModel=TaskViewModel()
    
    var dayRange = 7...24
    
    @State var blurEffect:CGFloat = 0


    
    var body: some View {
        
        GeometryReader { geometry in
            
        
       VStack{
        
               // WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
 
       
        
            List(self.dayRange,id:\.self){
                    hour in
                HStack{
                    
                if(hour > 9)
                {
                
                    BigChar(hour:String(hour)).padding(.leading,-170)
                }
                else{
                    
                    BigChar(hour:"0"+String(hour)).padding(.leading,-170)
                }
                
                ForEach(self.taskViewModel.retrieveAllDayTasks(hour:hour))
                    {
                        weekByHour in
                        GeometryReader{
                            geometry in
                       
                            HStack {
                               /* if(self.taskViewModel.retrieveAllTasksByHour(hour:hour).count > 4)
                                {
                                Text(String(self.taskViewModel.retrieveAllTasksByHour(hour:hour)[4].isEmptySlot))
                                }*/
                                
                    
                               
                                WeeklyTasksRow(timeChar:String(hour),hourTasks: weekByHour).frame( alignment: .bottom).frame(width:geometry.size.width*0.8)
                                   
                            
                                
                            }
                         }
                        
                    }
        }
                
                        /*Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-5, trailing: 0))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))*/
                    }
             /*   HStack{
                     Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                
                    TestTaskRow(taskName: "Algebra 1",heightFactor: CGFloat(0.7)).padding(EdgeInsets(top:-8, leading: 0, bottom:0, trailing: 0))
                    
                    TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                }*/
        
            
            }
        }  //.navigationBarTitle(Text("Daily Schedule").foregroundColor(.green))
    }
}

/*struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}

*/
