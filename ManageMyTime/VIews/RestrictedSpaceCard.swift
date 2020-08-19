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
    @State var height:CGFloat=370
    @State var paddingBottom:CGFloat=15
    //@Binding var position:CGFloat
    
 
    
    var body: some View {
           
        ZStack(alignment: .leading) {
   
                Color.flatDarkCardBackground
               
                HStack {
                   
                   
                    
                    HStack {
                          Button(action: {
                                                                   
                                
                                                                                             
                                    }) {
                                     
                                       VStack{  Image(systemName: "pencil").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                         Text("Edit Task").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                        
                                                                        
                          }
                           
                        
                           
                           Button(action: {
                                            
                      
                                 
                                                                      
                                 }) {
                                   VStack{
                                     Image(systemName: "trash").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                     Text("Delete").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                         
                                                                         
                           }
                        Spacer()
                        VStack{
                           HStack{
                               // Spacer()
                                Text(self.dayOfTheWeek)
                            .font(.system(size: 20))
                            //.font(.headline)
                           
                            .fontWeight(.bold).padding(1)
                                    .lineLimit(2).foregroundColor(.white)
                            //.background(Capsule().fill(self.color))
                            //.padding(.bottom, 2)
                               Spacer()
                            }.padding(.bottom,7)
                            
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
                                  }.padding(.bottom,20)
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
                               }.padding(.bottom,20)
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
                   
                }.padding(EdgeInsets(top: 15, leading: paddingBottom, bottom: 15, trailing: 15)).frame(width:self.height,height:130) .background(
                    self.colorScheme == .dark ? ( LinearGradient(
                        gradient: Gradient(colors: [self.color,Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),self.color]),
                        startPoint: .topTrailing,
                                 endPoint:.bottomTrailing
                               )) :(
                   LinearGradient(
                    gradient: Gradient(colors: [.white,self.color,self.color,self.color,.white]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                     //self.color,.purple,.purple,.purple
                        startPoint: .top,
                      endPoint:.bottom
                    ))).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black,lineWidth:1.5)).frame(width:self.height)

            }
        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y: self.offset).padding(EdgeInsets(top: 15, leading: paddingBottom, bottom: 15, trailing: 450)).frame(width:self.height,height:130)
        .simultaneousGesture(TapGesture().onEnded{
                                                     // print("Got Tap")
                                                    
            withAnimation(.easeInOut) {
                if(!self.displayItem)
                {
                    self.height=570//Higher height settings: 400
                    self.paddingBottom=200//260
                    self.padding = -85//-115
                     self.displayItem=true
                }
                else{
                    self.height=370
                    self.paddingBottom=15
                    self.padding = 0
                     self.displayItem=false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                                                self.height=370
                                                                self.paddingBottom=15
                                                                self.padding = 0
                                                                 self.displayItem=false
                    }
                                           }
                                   
            }
                                //delay(0.5)
                                
        })
       
        
    }
}

/*struct RestrictedSpaceCard_Previews: PreviewProvider {
   @State var position:CGFloat=4
    static var previews: some View {
       CardTaskRow(taskName1: "Check", dueDate1: "28/09/05", importance1: "High", workTimeHour: 6, workTimeMinutes: 30,startTimeHour:5,startTimeMinutes:30,endTimeHour:7,endTimeMinutes:50, scheduledDate: "28/09/05", color: Color(.systemPink),position: $position)
    }
}*/

