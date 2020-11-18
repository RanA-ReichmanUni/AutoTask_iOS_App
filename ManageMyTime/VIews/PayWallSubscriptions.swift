//
//  PayWallSubscriptions.swift
//  ManageMyTime
//
//  Created by רן א on 04/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PayWallSubscriptions: View {
    @ObservedObject var taskViewModel:TaskViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var alternativeText=false
    @State var showAlert=false
    
    @Binding var press:Bool
    @Binding var presentPayWall:Bool
    
    var body: some View {
        VStack{
            
                
            
          
                
           
      
                        
        
                          Spacer()
              
             Text("Available Subscriptions").font(Font.custom("MarkerFelt-Wide", size: 36)).bold()
          
           
               // Spacer()
            if(self.taskViewModel.SubscriptionTitles.isEmpty)
            {
                Text("Fetching Information...").font(Font.custom("MarkerFelt-Wide", size: 20)).bold()
            }
            else{
                   
                  
                ScrollView{
                   
                    ForEach(self.taskViewModel.SubscriptionObjects, id: \.id) { subscription in
                        
                        HStack{
                            Spacer()
                            Button(action:{
                                self.press=true
                            
                                self.alternativeText=true
                                self.taskViewModel.MakeAPurchase(package: subscription.packageObject)
                                
                                if(self.taskViewModel.hasFullAccess)
                                {
                                    self.mode.wrappedValue.dismiss()
                                }
                                
                                self.presentPayWall=false
                                
                                
                            })
                            {
                                
                                Text(self.alternativeText == true ? "Processing, Please Wait..." : subscription.text).frame(width:280,height:180).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                                
                            }.padding()
                              Spacer()
                        }
                    }.background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.4)).frame(width:300))
                }
                /*HStack{
                Button(action:{self.showAlert=true})
                 {
                      Text("Notice About Trail Periods").frame(width:220,height:25).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 25).fill(Color.gray))
                 }
                    //Spacer()
                }*/
            }
            Spacer()
            
      
            }.background(Image("robotHand") .resizable()
                       
                                 
                                      .aspectRatio(contentMode: .fill)).alert(isPresented: self.$showAlert){
            
            
           return Alert(title: Text("Trail Periods Model On In App Purchases"),
            message:  Text("\n\nThe Annual Payment On Plans That Offer Free Trail Period Will Start Immediatly After The Free Trail Period Is Over.\nCurrently This Model Is The Only Way To Offer Free Trails. \n If You Don't Wish To Use Auto Task Services And Subscribe For The Annual Subscription, You Can Cancel The Subscription Before The Trail Period Ends. \n\nAutoTask On The Other Hand Would Love To Be At Your Service :) ").font(.system(size: 16)),
            dismissButton: .default(Text("OK")))
            
              
        }
        
    }
}

/*struct PayWall_Previews: PreviewProvider {
    static var previews: some View {
        PayWall()
    }
}*/
