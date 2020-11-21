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
    @Environment(\.colorScheme) var colorScheme
    let helper=HelperFuncs()
  //  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var timeChar = "25"
    //var columns : [String]
    
    @ObservedObject var taskViewModel:TaskViewModel
    var hoursRange = 6...24
    @State var show=false
    @State var key=false
    @Binding var rangeOfHours:[Int]
    func isIOS13VariationsChecker() -> Bool
    {
        if #available(iOS 14, *) {
            // use UICollectionViewCompositionalLayout
            return false
        } else {
            // show sad face emoji
            return true
        }
        
    }
    var body: some View {
        UITableView.appearance().backgroundColor = self.colorScheme == .dark ? Color.black.uiColor() : Color(hex:"#fcfcfc").uiColor()
                  return
        GeometryReader { geometry in
            
        
            VStack(spacing:0){
           
                HStack{
                    
                    Text("Weekly Schedule").font(Font.custom("MarkerFelt-Wide", size: 26)).bold()
                    Spacer()
             
                        HStack{
                    Text(self.helper.dateToStringNormalizedExcludYear(date:Date().startOfWeek)).font(Font.custom("MarkerFelt-Wide", size: 18)).bold().foregroundColor(Color(.systemTeal))
                    Text(" - ").font(Font.custom("MarkerFelt-Wide", size: 18)).bold()
                            Text(self.helper.dateToStringNormalizedExcludYear(date:Date().endOfWeek)).font(Font.custom("MarkerFelt-Wide", size: 18)).bold().foregroundColor(Color.blue)
                        }.background( RoundedRectangle(cornerRadius: 20).fill(self.colorScheme == .dark ? Color.orange.opacity(0.3) : Color(hex:"#e6f2ff")).frame(width:150,height:40))
                       
                    
                    
                }.padding(20)
        WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
        
    
     
                List(self.rangeOfHours,id:\.self){
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
              
                    ForEach(self.taskViewModel.retrieveAllTasksByHourOrginal(hour:hour),id:\.id)
                    {
                        weekByHour in
       
                 
                           
                                ScehduleSelector(hour:String(hour),weekByHour: weekByHour,geometry:geometry).listRowBackground(Color.green)
                            
                        
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
              
                }/*.id(UUID()).animation(.easeInOut(duration: 1))*//*.id(UUID())*/.frame( maxWidth: .infinity, maxHeight: .infinity)//.colorMultiply(Color(hex:"#fff3d4"))
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
        


            }.onAppear{
                
                if(isIOS13VariationsChecker())
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                       
                           withAnimation(.easeInOut(duration: 0.1))
                           {
                       for index in 6...10
                              {
                       
                                   
                                  self.rangeOfHours.append(index)
                                   
                                     
                               }
                               
                           }
                           
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                           for index in 11...15
                                  {
                           
                                       
                                      self.rangeOfHours.append(index)
                                       
                                         
                                   }
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                           for index in 16...24
                                                 {
                                          
                                                      
                                                     self.rangeOfHours.append(index)
                                                      
                                                        
                                                  }
                                                  
                                              }
                       }
                               
                           
                   }
                   
                    
                    
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        
                        withAnimation(.easeInOut(duration: 0.1))
                        {
                    for index in 6...24
                           {
                    
                                
                               self.rangeOfHours.append(index)
                                
                                  
                            }
                            
                        }
                     
                        
                                
                            
                    }
                }
            }
        }.onDisappear{
            self.rangeOfHours=[]
         withAnimation(.ripple2())
                                         {
         self.taskViewModel.hoursRange=[]
         }
            
        }.background(self.colorScheme == .dark ? Color.black : Color(hex:"#f9f9f9").opacity(0.1)).onDisappear{self.taskViewModel.retrieveAllTasks()}  .navigationBarTitle(Text("Weekly Schedule")).animation(.easeInOut(duration: 0.5))
    }
}

/*struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow()/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}
*/

