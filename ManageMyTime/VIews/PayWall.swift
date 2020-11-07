//
//  PayWall.swift
//  ManageMyTime
//
//  Created by רן א on 05/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PayWall: View {
    @ObservedObject var taskViewModel:TaskViewModel
    @State var presentPayWall=false
    var body: some View {
    
        
        GeometryReader{ geometry in
            VStack{
                
                Image("robotHand")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                
                Text(UserDefaults.standard.bool(forKey: "hasBeenSubscribed") ? "Your Subscription Has been Expired/Canceled.\n\nPlease Chose A New One Below:" : "AutoTask Requires A Subscription Plan.\n\nPlease Chose One Below:").font(Font.custom("MarkerFelt-Wide", size: 26)).bold()
                Spacer()
                Button(action:{self.presentPayWall=true})
                   {
                       
                       Text("Chose A Subscription Plan").frame(width:240,height:70).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                       
                }.padding().sheet(isPresented: self.$presentPayWall)
                {
                    
                    PayWallSubscriptions(taskViewModel: self.taskViewModel).onAppear{self.taskViewModel.retrieveSubscriptionsInfo()}
                    
                }
                
                
                /* Button(action:{self.taskViewModel.SetAccessTest()})
                   {
                       
                       Text("Full Access Test").frame(width:240,height:70).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                       
                }.padding()*/
                
                
                
            }
            
            
            
            
            
        }
    }
}

/*struct PayWall_Previews: PreviewProvider {
    static var previews: some View {
        PayWall()
    }
}*/
