//
//  MenuView.swift
//  ManageMyTime
//
//  Created by רן א on 23/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Binding var showWeeklySchedule:Bool
     @Binding var showTesting:Bool
    @Binding var showMenu:Bool
    @Binding var showTasks:Bool
    var body: some View {
        HStack{
        if(showMenu)
        {
            VStack(alignment: .leading) {
                HStack {
                    Button(action:{
                        withAnimation(.easeInOut(duration:1.5)){self.showWeeklySchedule=true
                            self.showTesting=false
                             self.showTasks=false
                                                }})
                    {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Weekly Schedule")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .padding(.top, 100)
                HStack {
                    Button(action:{
                       withAnimation(.easeInOut(duration:1.5))
                       {    self.showWeeklySchedule=false
                            self.showTasks=true
                            self.showTesting=false}})
                        {
                    
                            Image(systemName: "creditcard")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Messages")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                }
                    .padding(.top, 30)
                
                HStack {
                    Button(action:{
                        
                            withAnimation(.easeInOut(duration:1.5))
                            {   self.showWeeklySchedule=false
                                self.showTasks=false
                                self.showTesting=true
                                
                                                    }})
                        {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.gray)
                            .font(.headline)
                        }
                }
                .padding(.top, 30)
                Spacer()
            }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0, green: 0, blue: 0).opacity(0.8))
                .edgesIgnoringSafeArea(.all)
                  
        }
     
            
        else{
           Spacer()
        }
         Spacer()
        }.onTapGesture {
            withAnimation{
                self.showMenu=false
            }
        }
    }
}

/*struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
*/
