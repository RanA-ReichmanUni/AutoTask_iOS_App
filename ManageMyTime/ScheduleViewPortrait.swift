//
//  ScheduleViewPortrait.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct ScheduleViewPortrait: View {
    
    
    var timeChar = "25"
    //var columns : [String]
    
    var taskViewModel = TaskViewModel()
    var dayRange = 7...24
    
    var body: some View {
        
        GeometryReader { geometry in
            
        
       VStack{
        
        WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
        
       
        
            List(self.dayRange,id:\.self){
                    hour in
                
                if(hour > 9)
                {
                
                    Text(String(hour)).frame(width: geometry.size.width/18.7, height:  geometry.size.height/30)
                    
                    Divider()
                }
                else{
                    
                    HStack {
                        Text(String(0)).padding(EdgeInsets(top: 5, leading: -1, bottom:0, trailing: 0))
                        
                        Text(String(hour)).padding(EdgeInsets(top: 5, leading: -8, bottom:0, trailing:0))
                     
                        Divider()
                    }.frame(width: geometry.size.width/13, height:  geometry.size.height/30)
                }
                
                ForEach(self.taskViewModel.retrieveAllTasksByHour(hour:hour))
                    {
                        weekByHour in
                    
                        HStack {
                           /* if(self.taskViewModel.retrieveAllTasksByHour(hour:hour).count > 4)
                            {
                            Text(String(self.taskViewModel.retrieveAllTasksByHour(hour:hour)[4].isEmptySlot))
                            }*/
                            
                        
                           
                            //WeeklyTasksPotrait(timeChar:String(hour),hourTasks: weekByHour).frame(width: geometry.size.width/9, height:  geometry.size.height/15)
                            Divider().foregroundColor(Color.red).padding(EdgeInsets(top: 2, leading: 5, bottom: 1, trailing: 1))
                            
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
        }
    }
}

/*struct ScheduleViewPortrait_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow()/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}


*/
