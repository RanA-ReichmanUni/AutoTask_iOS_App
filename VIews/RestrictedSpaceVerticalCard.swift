//
//  RestrictedSpaceVerticalCard.swift
//  ManageMyTime
//
//  Created by רן א on 10/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct RestrictedSpaceVerticalCard: View {
    @ObservedObject var restrictedSpaceViewModel:RestrictedSpaceViewModel
    @ObservedObject var taskViewModel:TaskViewModel
    
     @Environment(\.colorScheme) var colorScheme
    var restrictedSpaceId:UUID
    var taskName1 : String
    var difficulty : String
    //var importance1 : String
   
    var startTimeHour:Int
    var startTimeMinutes:Int
    var endTimeHour:Int
    var endTimeMinutes:Int
    var dayOfTheWeek: String
    var color: Color
    @Binding var offset:CGFloat
    var id:UUID

    
    @State var padding:CGFloat=0
    @State var displayItem=false
    @State var height:CGFloat=290
    @State var paddingBottom:CGFloat = -60
    @State var vStackPadding:CGFloat = -85
    @State var lowerLinePadding:CGFloat=40
    //@Binding var position:CGFloat
    @State var isActive=false
    @State private var showingAlert = false
    @State var showEditUI=false
   // var internalId:UUID
    var isClickable:Bool
    // var geometry:GeometryProxy
    @State var windowType:Int=1
    @State var overlayPadding:CGFloat = 2
    @State var secondRowPadding:CGFloat = -55
    @State var thirdRowPadding:CGFloat = -35
    var body: some View {
           
        ZStack(alignment: .leading) {
   
                Color.flatDarkCardBackground
               // Spacer()
            
                 
                   
                    
                
            VStack{
                            HStack{
                               // Spacer()
                                Text(self.taskName1).font(Font.custom("Chalkduster", size: 22))
                            .font(.system(size: 20))
    
                            .fontWeight(.bold)
                                    .lineLimit(2).foregroundColor(.white)
         
                               Spacer()
                            }.padding(.top,self.isClickable ? vStackPadding : -20)
                            
                       // Text("Due:"+dueDate1)
                            //.padding(.bottom, 5)
                
                        HStack{
                            
                            ZStack() {
                               RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                         gradient: Gradient(colors: [self.color, self.color]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                               ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 0.2))
                                
                                
                      
                                Text("\(self.dayOfTheWeek)")
                                        .font(Font.custom("Chalkduster", size: 18))
                                        .foregroundColor(.white)
                                 
                               
                            }
                         .frame(width: 150, height: 30, alignment: .center)
                           
                            
                          // Text(self.dayOfTheWeek).font(Font.custom("Chalkduster", size: 18))
                           //.foregroundColor(.white)
                            
                      
                        Spacer()
                            HStack(spacing:0){
                               ZStack() {
                                     RoundedRectangle(cornerRadius: 10)
                                          .fill(
                                              LinearGradient(
                                               gradient: Gradient(colors: [self.color, self.color]),
                                                  startPoint: .topLeading,
                                                  endPoint: .bottomTrailing
                                              )
                                     ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 0.2))
                                      
                            
                                       Text("\(self.taskViewModel.AdjustViewHourStandard(value:self.startTimeHour))"+":"+"\(self.taskViewModel.AdjustViewHourStandard(value:self.startTimeMinutes))")
                                              .font(Font.custom("Noteworthy-Bold", size: 16))
                                              .foregroundColor(.white)
                                       
                                     
                                  }
                               .frame(width: 60, height: 30, alignment: .center)//.padding(.trailing,1)
                                           
                                Text(" - ").foregroundColor(Color.white)
                               ZStack() {
                                     RoundedRectangle(cornerRadius: 10)
                                       .fill(
                                           LinearGradient(
                                               gradient: Gradient(colors: [self.color, self.color]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing
                                           )
                                       ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 0.2))
                                   
                                
                                       Text("\( self.taskViewModel.AdjustViewHourStandard(value:self.endTimeHour))"+":"+"\( self.taskViewModel.AdjustViewHourStandard(value:self.endTimeMinutes))")
                                           .font(Font.custom("Noteworthy-Bold", size: 16))
                                           .foregroundColor(.white)
                                       
  
                               }
                               .frame(width: 60, height: 30, alignment: .center)
                                
                           }
                                      
                        }.padding(.top,self.isClickable ? secondRowPadding : 10)
                            VStack{
                              
                           HStack{
                                
                            CategoryPill(categoryName: "Difficulty: " + self.difficulty,color:            LinearGradient(
                                                               gradient: Gradient(colors: [self.color,self.color]),
                                                                                                                                        startPoint: .top,
                                                                                                                                        endPoint: .bottom
                                                                                                                                    ))
                                Spacer()
                                /* CategoryPill(categoryName: "Duration: " + self.taskViewModel.AdjustViewHourStandard(value:workTimeHour)+":"+self.taskViewModel.AdjustViewHourStandard(value:workTimeMinutes),color: LinearGradient(
                                                                    gradient: Gradient(colors: [self.color,self.color]),
                                                                         startPoint: .top,
                                                                         endPoint: .bottom
                                                                     ))*/
                          
                                
                            }.padding(.top,self.isClickable ? thirdRowPadding : 2)
                               /* HStack{
                                   
                                                                CategoryPill(categoryName: "Notes: " + notes,color: LinearGradient(
                                                                                                            gradient: Gradient(colors: [self.color,self.color]),
                                                                                                                 startPoint: .top,
                                                                                                                 endPoint: .bottom
                                                                                                             ))
                                    Spacer()
                                }.padding(.top,self.isClickable ? secondRowPadding : 2)*/
                        HStack{
                            
                     
                         /*   HStack{

                                 HStack(spacing:0){
                                         Text("Finished ")
                                         Toggle(isOn: $isActive) {
                                                                                          Text("sdgsddsh")
                                                        
                                         }.onTapGesture {
                                            self.taskViewModel.completedToggle(tasdkId: self.taskId)
                                            self.completed.toggle()
                                         }.labelsHidden()
                                 }.onAppear{self.isActive=self.completed}
                             }*/
                   
                            Spacer()
                            /*  Button(action: {
                                                                      
                                        self.displayItem=true
                                        self.windowType=2
                                                                                                
                                           }) {
                                            
                                              VStack{  Image(systemName: "pencil").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                Text("Edit").font(Font.custom("Chalkduster", size: 16)).foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                           
                                                                           
                             }*/
                              
                      
                              
                              Button(action: {
                                               
                         
                                    self.showingAlert = true
                                    
                                            }) {
                                              VStack{
                                                Image(systemName: "trash").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                Text("Delete").font(Font.custom("Chalkduster", size: 16)).foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                            
                                                                            
                              } .alert(isPresented:$showingAlert) {
                                         Alert(title: Text("Are you sure you want to delete this task ?"), message: Text("You can`t undo this action"), primaryButton: .destructive(Text("Delete")) {
                                                      self.restrictedSpaceViewModel.DeleteRestrictedSpace(id: self.id)
                                                        
                                                       //   self.mode.wrappedValue.dismiss()
                                            }, secondaryButton: .cancel())}
                            
                         /*   Button(action: {
                                                                                             
                                                          
                                                                                                                       
                                                                  }) {
                                                                   
                                                                     VStack{  Image(systemName: "square.and.arrow.up").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                                       Text("Expand").font(Font.custom("Chalkduster", size: 16)).foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                                                  
                                                                                                  
                                                    }*/
                                                     
              
                            
                            Spacer()
                          
                           
                        }.padding(.top, self.isClickable ? lowerLinePadding : 20)
                              
                            }
                            
                        }
 
                     
                 
                    
                   
                   
                .padding(EdgeInsets(top: 15, leading: 15, bottom: self.isClickable ? paddingBottom : 2, trailing: 15)).frame(height:self.height) .background(
                    self.colorScheme == .dark ? ( LinearGradient(
                        gradient: Gradient(colors: [self.color,Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),self.color]),
                        startPoint: .topTrailing,
                        endPoint:.bottomTrailing
                               )) :(
                   LinearGradient(
                    gradient: Gradient(colors: [self.color, self.color, self.color,.white]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                     //self.color,.purple,.purple,.purple
                        startPoint: .topLeading,
                      endPoint:.bottomTrailing
                               ))).shadow(radius: 15).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black,lineWidth: self.colorScheme == .dark ? 5 : 0.3)).frame(height:self.height).padding(.bottom,overlayPadding)

            }
        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y: self.offset).sheet(isPresented: self.$displayItem) {
            if(self.windowType==1)
            {
              /*  DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: self.taskName1,importance: self.importance1,dueDate: self.dueDate,notes: self.notes, asstimatedWorkTimeHour: self.workTimeHour,asstimatedWorkTimeMinutes:self.workTimeMinutes,startTimeHour:self.startTimeHour,startTimeMinutes:self.startTimeMinutes,endTimeHour:self.endTimeHour,endTimeMinutes:self.endTimeMinutes,day:self.date.day,month:self.date.month,year:self.date.year,taskId:self.id,color:self.color,displayItem:self.$displayItem, completed: self.$completed)/*.onTapGesture {*/
                    self.taskViewModel.getFirstTaskColor()
                        self.displayItem=false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                                       
                                      
                        withAnimation(.easeInOut(duration:1.2)) {  self.height=170
                             self.paddingBottom=15
                                self.padding = 0}
                    }
                     
                }.onDisappear{
                    self.taskViewModel.getFirstTaskColor()
                                    self.displayItem=false
                                    //self.padding = 0
                        self.taskViewModel.getFirstTaskColor()
                    
                   
                              
                    withAnimation(.easeInOut(duration:1.2)) {//self.height=170
                                    self.paddingBottom=15
                                        self.padding = 0
                                    self.vStackPadding=5}
                        
                }*/
                            
            }
            if(self.windowType==2)
            {
                
                        
              //  UpdateTask(taskViewModel: self.taskViewModel, taskName: self.taskName1, notes: self.notes, id: self.id,selectedColorIndex: self.color)
                        
                        
                
            }
            
        }.padding(EdgeInsets(top: padding, leading: 0, bottom: 0 , trailing: 0))
        .simultaneousGesture(TapGesture().onEnded{
                                                     // print("Got Tap")
                                                    
         //self.height=400//Higher height settings: 400
            if(self.isClickable)
            {
                if(self.paddingBottom == 5)
                {
                    
                       /* withAnimation(.easeInOut) {
                                //self.vStackPadding = 0
                               //self.lowerLinePadding = 20
                            
                    }*/
                    
                      
                    
                    //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                      //  withAnimation(.easeInOut) {
                            
                            self.paddingBottom = -60
                            self.padding = 0
                            self.vStackPadding = -85
                           self.lowerLinePadding = 20
                            self.overlayPadding=2
                            self.secondRowPadding = -55
                            self.thirdRowPadding = -35
                     //   }
                   // }
                }
            
                    
                
    
                
                
                else{
                  //  withAnimation(.easeInOut) {
                        self.paddingBottom=5//260
                        self.padding = -96//-115
                        self.vStackPadding = -25
                        self.lowerLinePadding = 10
                        self.secondRowPadding = 0
                        self.thirdRowPadding = 0
                        self.overlayPadding=98
                  //  }
                    
                   /* DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            if(self.paddingBottom == 70)
                            {
                               // withAnimation(.easeInOut) {
                                    // self.vStackPadding = 20
                                    self.lowerLinePadding = -20
                                    self.secondRowPadding = 2
                                  //  }
                                }
                            }*/
                                                     
                }
        }
               /* DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                              self.displayItem=true
                }*/
                
            
            
                
                                   
           
                                //delay(0.5)
                                
        })
        /*.simultaneousGesture(LongPressGesture().onEnded{ _ in
                                                           // print("Got Tap")
                                                          
                  withAnimation(.easeInOut) {self.height=340
                      self.paddingBottom=200
                      self.padding = -80
                                              
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                    self.displayItem=true
                                                 }
                                         
                  }
                                      //delay(0.5)
                                      
              })*/
        
        /*.onTapGesture {
            withAnimation(.easeIn(duration: 0.5)) { self.padding = 100 }
        }
          */
        
    }
}

/*struct RestrictedSpaceVerticalCard_Previews: PreviewProvider {
   @State var position:CGFloat=4
    static var previews: some View {
       CardTaskRow(taskName1: "Check", dueDate1: "28/09/05", importance1: "High", workTimeHour: 6, workTimeMinutes: 30,startTimeHour:5,startTimeMinutes:30,endTimeHour:7,endTimeMinutes:50, scheduledDate: "28/09/05", color: Color(.systemPink),position: $position)
    }
}*/




