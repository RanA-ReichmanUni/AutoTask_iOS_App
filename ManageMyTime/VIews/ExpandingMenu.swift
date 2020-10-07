//
//  ExpandingMenu.swift
//  ManageMyTime
//
//  Created by רן א on 06/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ExpandingMenu: View {
    
    @Binding var addTaskFlag:Bool
    @Binding var listFlag:Bool
    @Binding var showAddTask:Bool
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
        VStack {
            Spacer()
            if showMenuItem1 {
                MenuItem(name: "Repeated Activity",addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag,showAddTask: self.$showAddTask,showMenuItem1:self.$showMenuItem1,showMenuItem2:self.$showMenuItem2)
             
            }
            if showMenuItem2 {
                MenuItem(name: "Auto Schedule",image:"cpu-icon",addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag,showAddTask: self.$showAddTask,showMenuItem1:self.$showMenuItem1,showMenuItem2:self.$showMenuItem2)
            }

            Button(action: {
                self.showMenu()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(hex:"#d6ecff").opacity(0.93))
                    //.shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
        }//.animation(.easeInOut(duration: 0.5))
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

/*struct ExpandingMenu_Previews: PreviewProvider {
    static var previews: some View {
        ExpandingMenu()
    }
}*/

struct MenuItem: View {
    
    var name: String
    var image:String?
    @Binding var addTaskFlag:Bool
    @Binding var listFlag:Bool
    @Binding var showAddTask:Bool
    @Binding var showMenuItem1:Bool
    @Binding var showMenuItem2:Bool
    var body: some View {
        
        Button(action:{
            if(self.name == "Auto Schedule")
            {
               // self.listFlag=false
              //  self.addTaskFlag=true
                self.showAddTask=true
                 withAnimation {
                    self.showMenuItem2.toggle()
                    self.showMenuItem1.toggle()
                }
                
            }
            
        })
        {
            ZStack {
                RoundedRectangle(cornerRadius: 10)//.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                    .foregroundColor(Color(hex:"#d6ecff").opacity(0.9))
                    .frame(width: 210, height: 50)
                
                HStack{
                    if(self.image != nil)
                    {
                        Image(image!).resizable().frame(width: 30, height: 30)
                       // Image(systemName: image!) .resizable().frame(width: 30, height: 30).foregroundColor(.blue)
                    }
                    else{
                        Image(systemName:"repeat").resizable().frame(width: 30, height: 30)
                    }
                    Text(name)
                    .foregroundColor(.blue).font(Font.custom("MarkerFelt-Wide", size: 20))
                }
            }
        }
       // .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
