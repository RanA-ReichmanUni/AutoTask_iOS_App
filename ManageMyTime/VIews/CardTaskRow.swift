//
//  CardTaskRow.swift
//  ManageMyTime
//
//  Created by רן א on 10/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CardTaskRow: View {
    @ObservedObject var taskViewModel:TaskViewModel
     @Environment(\.colorScheme) var colorScheme
    var taskId:UUID
    var taskName1 : String
    var dueDate1 : String
    var importance1 : String
    var workTimeHour:Int
    var workTimeMinutes:Int
    var startTimeHour:Int
    var startTimeMinutes:Int
    var endTimeHour:Int
    var endTimeMinutes:Int
    var scheduledDate: String
    var color: Color
    @Binding var offset:CGFloat
    var date:CustomDate
    var notes:String
    var id:UUID
    var dueDate:Date
    @State var completed:Bool
    @State var padding:CGFloat=0
    @State var displayItem=false
    @State var height:CGFloat=290
    @State var paddingBottom:CGFloat=2
    @State var vStackPadding:CGFloat = 0
    @State var lowerLinePadding:CGFloat=20
    //@Binding var position:CGFloat
    @State var isActive=false
    @State private var showingAlert = false
 
    var body: some View {
           
        ZStack(alignment: .leading) {
   
                Color.flatDarkCardBackground
               // Spacer()
            
                 
                   
                    
                
            VStack{
                            HStack{
                               // Spacer()
                                Text(self.taskName1)
                            .font(.system(size: 20))
    
                            .fontWeight(.bold)
                                    .lineLimit(2).foregroundColor(.white)
         
                               Spacer()
                            }.padding(.top,vStackPadding)
                            
                       // Text("Due:"+dueDate1)
                            //.padding(.bottom, 5)
                
                        HStack{
                            CategoryPill(categoryName: "Scheduled to: "+self.scheduledDate,color:            LinearGradient(
                                gradient: Gradient(colors: [self.color,self.color]),
                                                                                                         startPoint: .top,
                                                                                                         endPoint: .bottom
                                                                                                     ))
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
                                     ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 0.1))
                                      
                            
                                       Text("\(self.startTimeHour)"+":"+"\(self.startTimeMinutes)")
                                              .font(.system(size: 20, weight: .bold))
                                              .foregroundColor(.white)
                                       
                                     
                                  }
                                  .frame(width: 60, height: 30, alignment: .center)
                                           
                                   
                               ZStack() {
                                     RoundedRectangle(cornerRadius: 10)
                                       .fill(
                                           LinearGradient(
                                               gradient: Gradient(colors: [self.color, self.color]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing
                                           )
                                       ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 0.1))
                                   
                                 
                                       Text("\(self.endTimeHour)"+":"+"\(self.endTimeMinutes)")
                                           .font(.system(size: 20, weight: .bold))
                                           .foregroundColor(.white)
                                       
  
                               }
                               .frame(width: 60, height: 30, alignment: .center)
                                
                           }
                                      
                        }.padding(.top,lowerLinePadding)
                            VStack{
                              
                            HStack{
                                
                                CategoryPill(categoryName: "Due Date: " + dueDate1,color:            LinearGradient(
                                                               gradient: Gradient(colors: [self.color,self.color]),
                                                                                                                                        startPoint: .top,
                                                                                                                                        endPoint: .bottom
                                                                                                                                    ))
                                Spacer()
                                CategoryPill(categoryName: "Work Time: " + String(workTimeHour)+":"+String(workTimeMinutes),color: LinearGradient(
                                                                    gradient: Gradient(colors: [self.color,self.color]),
                                                                         startPoint: .top,
                                                                         endPoint: .bottom
                                                                     ))
                                Spacer()
                                  CategoryPill(categoryName: "Notes: " + notes,color: LinearGradient(
                                                                              gradient: Gradient(colors: [self.color,self.color]),
                                                                                   startPoint: .top,
                                                                                   endPoint: .bottom
                                                                               ))
                                
                            }.padding(.top,lowerLinePadding)
            
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
                              Button(action: {
                                                                      
                                   
                                                                                                
                                           }) {
                                            
                                              VStack{  Image(systemName: "pencil").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                Text("Edit").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                           
                                                                           
                             }
                              
                      
                              
                              Button(action: {
                                               
                         
                                    self.showingAlert = true
                                                                         
                                            }) {
                                              VStack{
                                                Image(systemName: "trash").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                Text("Delete").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                            
                                                                            
                              } .alert(isPresented:$showingAlert) {
                                         Alert(title: Text("Are you sure you want to delete this task ?"), message: Text("You can`t undo this action"), primaryButton: .destructive(Text("Delete")) {
                                                      self.taskViewModel.deleteTask(taskId: self.taskId)
                                                            self.taskViewModel.getFirstTaskColor()
                                                       //   self.mode.wrappedValue.dismiss()
                                            }, secondaryButton: .cancel())}
                            
                            Button(action: {
                                                                                             
                                                          
                                                                                                                       
                                                                  }) {
                                                                   
                                                                     VStack{  Image(systemName: "square.and.arrow.up").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                                                       Text("Expand").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)}.padding()
                                                                                                  
                                                                                                  
                                                    }
                                                     
              
                            
                            Spacer()
                          
                           
                        }.padding(.top,lowerLinePadding)
                              
                            }
                            
                        }
 
                     
                 
                    
                   
                   
                .padding(EdgeInsets(top: 15, leading: 15, bottom: paddingBottom, trailing: 15)).frame(height:self.height) .background(
                    self.colorScheme == .dark ? ( LinearGradient(
                        gradient: Gradient(colors: [self.color,Color(hex:"#161518"),Color(hex:"#161518"),Color(hex:"#161518"),self.color]),
                        startPoint: .topTrailing,
                                 endPoint:.bottomTrailing
                               )) :(
                   LinearGradient(
                    gradient: Gradient(colors: [self.completed == false ? self.color: self.color.opacity(0.01),self.completed == false ? self.color: .white,self.completed == false ? self.color: .white,.white]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                     //self.color,.purple,.purple,.purple
                        startPoint: .topLeading,
                      endPoint:.bottomTrailing
                               ))).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black,lineWidth:1.5)).frame(height:self.height).padding(.bottom,paddingBottom)

            }
        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y: self.offset).sheet(isPresented: self.$displayItem) {
            DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: self.taskName1,importance: self.importance1,dueDate: self.dueDate,notes: self.notes, asstimatedWorkTimeHour: self.workTimeHour,asstimatedWorkTimeMinutes:self.workTimeMinutes,startTimeHour:self.startTimeHour,startTimeMinutes:self.startTimeMinutes,endTimeHour:self.endTimeHour,endTimeMinutes:self.endTimeMinutes,day:self.date.day,month:self.date.month,year:self.date.year,taskId:self.id,color:self.color,displayItem:self.$displayItem, completed: self.$completed)/*.onTapGesture {
                self.taskViewModel.getFirstTaskColor()
                    self.displayItem=false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                                   
                                  
                    withAnimation(.easeInOut(duration:1.2)) {  self.height=170
                         self.paddingBottom=15
                            self.padding = 0}
                }
                 
            }*/.onDisappear{
                self.taskViewModel.getFirstTaskColor()
                                self.displayItem=false
                                //self.padding = 0
                    self.taskViewModel.getFirstTaskColor()
                
               
                          
                withAnimation(.easeInOut(duration:1.2)) {//self.height=170
                                self.paddingBottom=15
                                    self.padding = 0
                                self.vStackPadding=5}
                    
            }
                            
                
            
        }.padding(EdgeInsets(top: padding, leading: 0, bottom: 0 , trailing: 0))
        .simultaneousGesture(TapGesture().onEnded{
                                                     // print("Got Tap")
                                                    
         //self.height=400//Higher height settings: 400
                if(self.paddingBottom == 100)
                {
                    
                        withAnimation(.easeInOut) {
                                //self.vStackPadding = 0
                               //self.lowerLinePadding = 20
                            
                    }
                    
                      
                    
                    //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.easeInOut) {
                            
                            self.paddingBottom=2
                            self.padding = 0
                            self.vStackPadding = 0
                           self.lowerLinePadding = 20
                     //   }
                    }
                }
            
                    
                
    
                
                
                else{
                    withAnimation(.easeInOut) {
                         self.paddingBottom=100//260
                         self.padding = -95//-115
                         self.vStackPadding = 119
                         self.lowerLinePadding = 25
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            if(self.paddingBottom == 100)
                            {
                                withAnimation(.easeInOut) {
                                     self.vStackPadding = 30
                                    self.lowerLinePadding = -1}
                                }
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

/*struct CardTaskRow_Previews: PreviewProvider {
   @State var position:CGFloat=4
    static var previews: some View {
       CardTaskRow(taskName1: "Check", dueDate1: "28/09/05", importance1: "High", workTimeHour: 6, workTimeMinutes: 30,startTimeHour:5,startTimeMinutes:30,endTimeHour:7,endTimeMinutes:50, scheduledDate: "28/09/05", color: Color(.systemPink),position: $position)
    }
}*/

extension UIColor {
    
    static let flatDarkBackground = UIColor(red: 36, green: 36, blue: 36)
    static let flatDarkCardBackground = UIColor(red: 46, green: 46, blue: 46)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var flatDarkBackground: Color {
        return Color(decimalRed: 36, green: 36, blue: 36)
    }
    
    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 255, green: 255, blue: 255)
    }
}

struct CategoryPill: View {
    
    var categoryName: String
    var fontSize: CGFloat = 15.0
    var color:LinearGradient
    var body: some View {
        ZStack {
            Text(categoryName)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(100)
                .foregroundColor(.white)
                .padding(5)
                .background(color)
                .cornerRadius(5)
        }
    }
}

extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}

extension Animation {
    static func ripple2() -> Animation {
        Animation.spring(dampingFraction: 0.15)
            .speed(3)
    }
    

}
