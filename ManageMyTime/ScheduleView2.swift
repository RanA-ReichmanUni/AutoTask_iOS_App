//
//  ScheduleView.swift
//  ManageMyTime
//
//  Created by רן א on 30/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ScheduleView2: View {
     @State private var color = Color.black
    let times = [7,8,9,10,11,12,13,14,15,16]
    let value = UIInterfaceOrientation.landscapeRight.rawValue
    @State var isFirstRun = false
    
    @ViewBuilder
    var body: some View {
        
           HStack{
                VStack{
                    
                             Text("Time").foregroundColor(Color.red).font(.system(size: 16)).padding(EdgeInsets(top: 15, leading: 0, bottom: -5, trailing: 0))
                   
             
                    List(times , id:\.self) {
                        time in
                     
                  
                        
                                  Text(String(time)).font(.system(size: 13)).lineSpacing(2).lineLimit(3).padding(EdgeInsets(top: 15, leading: 5, bottom: -5, trailing: 0))
                        /*
                         Text("9-10").font(.system(size: 13)).lineSpacing(2).lineLimit(3)
                         Text("10-11").font(.system(size: 13)).lineSpacing(2).lineLimit(3)
                         Text("12-13").font(.system(size: 13)).lineSpacing(2).lineLimit(3)
                         Text("7-8").font(.system(size: 13)).lineSpacing(2).lineLimit(3)
                         Text("7-8").font(.system(size: 13)).lineSpacing(2).lineLimit(3)
                        */
                        }
                
            }
            List {
                Text("S").foregroundColor(Color.red)
                    Text("2")
                 }
           
           ScrollView {
            Text("M").foregroundColor(Color.red).padding(EdgeInsets(top: 11.5, leading: -5, bottom: 19, trailing: 0))
                
                Text("Complexity excresize 1").font(.system(size: 13)).lineSpacing(2).lineLimit(3) .foregroundColor(Color.white)
                           .colorMultiply(self.color)
                           .onTapGesture {
                               withAnimation(.easeInOut(duration: 1)) {
                                   self.color = Color.blue
                               }
                }
            Text("Infi B excresize 18").font(.system(size: 13)).lineSpacing(2).lineLimit(3).padding(EdgeInsets(top: 11, leading: 0, bottom: 19, trailing: 0)).lineSpacing(2).lineLimit(4)
             Text("Infi Bdsfdsg hjgkg").lineSpacing(2).lineLimit(2).font(.system(size: 13)).lineSpacing(2).lineLimit(4).padding(EdgeInsets(top: 21, leading: 0, bottom: 19, trailing: 0))
              Text("Infi Bdsfdsg hjgkg").lineSpacing(2).lineLimit(2).font(.system(size: 13)).lineSpacing(2).lineLimit(4).padding(EdgeInsets(top: 11, leading: 0, bottom: 19, trailing: 0))
            }
            List {
                               Text("T").foregroundColor(Color.red)
                               Text("2")
                           }
            List {
                               Text("W").foregroundColor(Color.red)
                               Text("2")
                           }
            List {
                                Text("T").foregroundColor(Color.red)
                                Text("2")
                            }
            
            List {
                               Text("F").foregroundColor(Color.red)
                               Text("2")
                           }
            List {
                               Text("S").foregroundColor(Color.red)
                               Text("2")
                           }
         
    
            
    }
}
}

struct ScheduleView2_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView2().previewLayout(.fixed(width: 600, height: 300 ))
    }
}
