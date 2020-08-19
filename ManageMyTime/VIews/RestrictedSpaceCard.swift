//
//  RestrictedSpaceCard.swift
//  ManageMyTime
//
//  Created by רן א on 18/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//


import SwiftUI

struct RestrictedSpaceCard: View {
    //@ObservedObject var taskViewModel:TaskViewModel
     @Environment(\.colorScheme) var colorScheme
    var dayOfTheWeek : String
    var startTimeHour:Int
    var startTimeMinutes:Int
    var endTimeHour:Int
    var endTimeMinutes:Int
    @Binding var offset:CGFloat

    var id:UUID
    var color:Color=Color(.systemTeal)
    @State var padding:CGFloat=0
    @State var displayItem=false
    @State var height:CGFloat=170
    @State var paddingBottom:CGFloat=15
    //@Binding var position:CGFloat
    
 
    
    var body: some View {
           
        ZStack(alignment: .leading) {
   
                Color.flatDarkCardBackground
                Spacer()
                HStack {
                     Spacer()
                   
                    
                    HStack {
                        VStack{
                           HStack{
                               // Spacer()
                                Text(self.dayOfTheWeek)
                            .font(.system(size: 20))
                            //.font(.headline)
                           
                            .fontWeight(.bold).padding(4)
                                    .lineLimit(2).foregroundColor(.white)
                            //.background(Capsule().fill(self.color))
                            //.padding(.bottom, 2)
                               Spacer()
                            }.padding(.bottom,10)
                            
                       // Text("Due:"+dueDate1)
                            //.padding(.bottom, 5)
                        HStack{
                     
                        Spacer()
                            HStack{
                               ZStack() {
                                     RoundedRectangle(cornerRadius: 10)
                                          .fill(
                                              LinearGradient(
                                               gradient: Gradient(colors: [self.color, self.color]),
                                                  startPoint: .topLeading,
                                                  endPoint: .bottomTrailing
                                              )
                                          )
                                      
                                      VStack {
                                       Text("\(self.startTimeHour)"+":"+"\(self.startTimeMinutes)")
                                              .font(.system(size: 20, weight: .bold))
                                              .foregroundColor(.white)
                                       
                                      }
                                  }
                                  .frame(width: 60, height: 30, alignment: .center)
                                           
                                          //
                               ZStack() {
                                     RoundedRectangle(cornerRadius: 10)
                                       .fill(
                                           LinearGradient(
                                               gradient: Gradient(colors: [self.color, self.color]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing
                                           )
                                       )
                                   
                                   VStack {
                                       Text("\(self.endTimeHour)"+":"+"\(self.endTimeMinutes)")
                                           .font(.system(size: 20, weight: .bold))
                                           .foregroundColor(.white)
                                       
  
                                   }
                               }
                               .frame(width: 60, height: 30, alignment: .center)
                                
                           }
                                      
                        }
                  
                     
                        //.padding(.bottom, 5)
                        }
                        //Spacer()
                   
                        Spacer()
                              // Rectangle().fill(Color.white).frame(width:10)
                       /* VStack {
                            ForEach(scheduledDate, id: \.self) { category in
                                CategoryPill(categoryName: category,color:LinearGradient(
                                    gradient: Gradient(colors: [Color(hex:"#3CD3AD"),Color(hex:"#4CB8C4")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )).padding(EdgeInsets(top: 2, leading: 1, bottom: 2, trailing: 1))
                            }
                          
                        
                        }*/
                        
                    }
                    .padding(.horizontal, 5)
                    /* VStack{
                    //Spacer()
                       HStack{
                    ZStack() {
                                              RoundedRectangle(cornerRadius: 10)
                                                   .fill(
                                                       LinearGradient(
                                                        gradient: Gradient(colors: [self.color, self.color]),
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomTrailing
                                                       )
                                                   )
                                               
                                               VStack {
                                                Text("\(self.startTimeHour)"+":"+"\(self.startTimeMinutes)")
                                                       .font(.system(size: 20, weight: .bold))
                                                       .foregroundColor(.white)
                                                
                                               }
                                           }
                                           .frame(width: 60, height: 30, alignment: .center)
                    
                   //
                    ZStack() {
                                                                      RoundedRectangle(cornerRadius: 10)
                                                                        .fill(
                                                                            LinearGradient(
                                                                                gradient: Gradient(colors: [self.color, self.color]),
                                                                                startPoint: .topLeading,
                                                                                endPoint: .bottomTrailing
                                                                            )
                                                                        )
                                                                    
                                                                    VStack {
                                                                        Text("\(self.endTimeHour)"+":"+"\(self.startTimeMinutes)")
                                                                            .font(.system(size: 20, weight: .bold))
                                                                            .foregroundColor(.white)
                                                                        
                                   
                                                                    }
                                                                }
                                                                .frame(width: 60, height: 30, alignment: .center)
                     
                }
                .padding(15)
             /**/
                    }.padding()*/
                   
                }.padding(EdgeInsets(top: 15, leading: 15, bottom: paddingBottom, trailing: 15)).frame(height:self.height) .background(
                    self.colorScheme == .dark ? ( LinearGradient(
                        gradient: Gradient(colors: [self.color,Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),self.color]),
                        startPoint: .topTrailing,
                                 endPoint:.bottomTrailing
                               )) :(
                   LinearGradient(
                        gradient: Gradient(colors: [.white,self.color,self.color,self.color,.white]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                     //self.color,.purple,.purple,.purple
                        startPoint: .topLeading,
                      endPoint:.bottomTrailing
                    ))).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black,lineWidth:1.5)).frame(height:self.height)

            }
        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y: self.offset)/*.sheet(isPresented: self.$displayItem) {
            DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: self.taskName1,importance: self.importance1,dueDate: self.dueDate,notes: self.notes, asstimatedWorkTimeHour: self.workTimeHour,asstimatedWorkTimeMinutes:self.workTimeMinutes,startTimeHour:self.startTimeHour,startTimeMinutes:self.startTimeMinutes,endTimeHour:self.endTimeHour,endTimeMinutes:self.endTimeMinutes,day:self.date.day,month:self.date.month,year:self.date.year,taskId:self.id,color:self.color).onTapGesture {
                self.taskViewModel.getFirstTaskColor()
                    self.displayItem=false
                   
                withAnimation(.easeInOut(duration:1.5)) {  self.height=170
                 self.paddingBottom=15
                    self.padding = 0}
                 
            }.onDisappear{
                self.taskViewModel.getFirstTaskColor()
                                self.displayItem=false
                                //self.padding = 0
                withAnimation(.easeInOut(duration:1.5)) {self.height=170
                                self.paddingBottom=15
                                    self.padding = 0}
                                self.taskViewModel.getFirstTaskColor()
                                
                            }
        }*/.padding(EdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0))
        .simultaneousGesture(TapGesture().onEnded{
                                                     // print("Got Tap")
                                                    
            withAnimation(.easeInOut) {self.height=340//Higher height settings: 400
                self.paddingBottom=200//260
                self.padding = -85//-115
                                        
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                              self.displayItem=true
                                           }
                                   
            }
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

/*struct RestrictedSpaceCard_Previews: PreviewProvider {
   @State var position:CGFloat=4
    static var previews: some View {
       CardTaskRow(taskName1: "Check", dueDate1: "28/09/05", importance1: "High", workTimeHour: 6, workTimeMinutes: 30,startTimeHour:5,startTimeMinutes:30,endTimeHour:7,endTimeMinutes:50, scheduledDate: "28/09/05", color: Color(.systemPink),position: $position)
    }
}*/

