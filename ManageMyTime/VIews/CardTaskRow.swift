//
//  CardTaskRow.swift
//  ManageMyTime
//
//  Created by רן א on 10/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CardTaskRow: View {
    
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
                                Text(self.taskName1)
                            .font(.system(size: 20))
                            //.font(.headline)
                           
                            .fontWeight(.bold).padding(4)
                                    .lineLimit(2).foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 5).fill(self.color))
                            //.padding(.bottom, 2)
                               Spacer()
                            }.padding(.bottom,10)
                            
                       // Text("Due:"+dueDate1)
                            //.padding(.bottom, 5)
                        HStack{
                            CategoryPill(categoryName: self.scheduledDate,color:            LinearGradient(
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
                                      
                        }
                        HStack {
                            HStack{
                            Image(systemName: "exclamationmark.circle").isHidden(true)
                                Text(self.importance1).foregroundColor(Color.white).isHidden(true)
                            }
                           // Spacer()
                            Spacer()
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
                   
                }.padding() .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(
                    gradient: Gradient(colors: [.white,self.color,self.color]),
                    startPoint: .top,
                  endPoint:.bottomLeading
                ))).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black,lineWidth:0.5))

        }
        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y: self.offset)
          
        
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
                .lineLimit(2)
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
