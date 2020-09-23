//
//  ScheduleViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI



struct ScheduleViewRow: View {
          @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  //  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var timeChar = "25"
    //var columns : [String]
    
    @ObservedObject var taskViewModel=TaskViewModel()
    var hoursRange = 7...24

    var body: some View {
        
        GeometryReader { geometry in
            
        
            VStack(spacing:0){
           
        WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
        
    
     
            List(self.hoursRange,id:\.self){
                    hour in
            
               if(hour > 9)
                {
                
                 ListTextHourSelector(hour: String(hour), geometryWidth: geometry.size.width, geometryHeight: geometry.size.height)
                }
                else{
                    ListTextHourSelector(hour: "0"+String(hour), geometryWidth: geometry.size.width, geometryHeight: geometry.size.height)
                    
                  /*  HStack {
                        Text(String(0)).padding(EdgeInsets(top: 5, leading: -1, bottom:0, trailing: 0))
                        
                        Text(String(hour)).padding(EdgeInsets(top: 5, leading: -8, bottom:0, trailing:0))
                     
                        Divider()
                    }.frame(width: geometry.size.width/13, height:  geometry.size.height/30)*/
                }
                HStack(spacing:4){
                ForEach(self.taskViewModel.retrieveAllTasksByHour(hour:hour))
                    {
                        weekByHour in
       
                        VStack{
                           /* if(self.taskViewModel.retrieveAllTasksByHour(hour:hour).count > 4)
                            {
                            Text(String(self.taskViewModel.retrieveAllTasksByHour(hour:hour)[4].isEmptySlot))
                            }*/
                           // Text(geometry.size.width.description)
                         
                            ScehduleSelector(hour:String(hour),weekByHour: weekByHour,geometry:geometry).listRowBackground(Color.green)
                        }
                          //  WeeklyTasksRow(timeChar:String(hour),hourTasks: weekByHour).frame(height:  geometry.size.height*0.098)
                            
                          //  Divider()
                            
                          
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
              
                }/*.id(UUID())*/.frame( maxWidth: .infinity, maxHeight: .infinity)//.colorMultiply(Color(hex:"#fff3d4"))
        //  Spacer()
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
        }.onDisappear{self.taskViewModel.retrieveAllTasks()}  .navigationBarTitle(Text("Weekly Schedule").foregroundColor(Color.blue)).animation(.default)
    }
}

/*struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow()/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}
*/

