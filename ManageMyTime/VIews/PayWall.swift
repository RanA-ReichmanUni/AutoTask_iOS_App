//
//  PayWall.swift
//  ManageMyTime
//
//  Created by רן א on 05/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

/*struct PayWall: View {
    @ObservedObject var taskViewModel:TaskViewModel
    @State var presentPayWall=false
    @State var showAlert=false
    @State var alertType=3
    @State var press=false
    @State var firstTry=true
    var receiptAssessor:ReceiptAssessor
    
    var body: some View {
    
        
        GeometryReader{ geometry in
            VStack{
                
                Image("robotHand")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                if(!self.press==true)
                {
                    
                        
                        Text(UserDefaults.standard.bool(forKey: "hasBeenSubscribed") ? "Your Subscription Has been Expired/Canceled.\nPlease Choose a New Subscription Plan Below." : "Auto Task Requires a Subscription Plan.\n\nChoose One Below:").font(Font.custom("MarkerFelt-Wide", size: 26)).bold()
                     
                   
                    if(UserDefaults.standard.bool(forKey: "hasBeenSubscribed"))
                    {Text("\n\n*If You Are Using The Device In Airplane Mode, Please Connect Your Device To The Internet.").font(Font.custom("MarkerFelt-Wide", size: 20))}
                    Spacer()
                    VStack{
                        HStack{
                        Spacer()
                        Button(action:{self.presentPayWall=true
                            //self.taskViewModel.retrieveSubscriptionsInfo()
                        })
                           {
                               //width:240,height:70
                            Text("Choose a Subscription Plan").frame(minWidth: 130, idealWidth: 240, maxWidth: 250, minHeight: 60 , idealHeight: 70, maxHeight: 80, alignment: .center).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                               
                        }.padding().sheet(isPresented: self.$presentPayWall)
                        {
                            
                            PayWallSubscriptions(taskViewModel: self.taskViewModel,press:self.$press,presentPayWall:self.$presentPayWall)
                            
                        }
                        Spacer()
                     
                      
                            Button(action:{
                                //self.taskViewModel.DefaultRestoreSubscriptionValues()
                                
                               // self.taskViewModel.CheckSubscription()
                                // self.taskViewModel.CheckSubscription()
                                    self.showAlert=true
                                    self.alertType=1
                                    
                                    if(self.taskViewModel.hasFullAccess)
                                       {
                                           self.showAlert=true
                                           self.alertType=3
                                           
                                       }
                              
                                         DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            if(!self.taskViewModel.hasFullAccess&&self.taskViewModel.returnedFromCall)
                                       {
                                           
                                           self.showAlert=true
                                           self.alertType=4
                                          
                                       }
                                            self.taskViewModel.returnedFromCall=false
                                }
                                
                            })
                            {
                                  
                                Text("Restore Existing Subscription").frame(minWidth: 130, idealWidth: 240, maxWidth: 250, minHeight: 60 , idealHeight: 70, maxHeight: 80, alignment: .center).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color(.systemTeal)))
                                  
                            }.padding()
                                 Spacer()
                        
                        
                    /*   Button(action:{
                               self.taskViewModel.SetOverrideFullAccess()
                               
                               
                           })
                           {
                                 
                               Text("Testing Override Access").frame(minWidth: 130, idealWidth: 240, maxWidth: 250, minHeight: 60 , idealHeight: 70, maxHeight: 80, alignment: .center).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color(.systemTeal)))
                                 
                           }.padding()
                                Spacer()*/
                        
                        
                       
                        
                      
                    }
                        
                        HStack{
                            Spacer()
                            Button(action:
                                    {
                                        if(self.taskViewModel.reachedTrailLimit)
                                        {
                                            self.showAlert=true
                                            self.alertType=5
                                        }
                                        else{
                                            withAnimation(.easeInOut(duration: 0.6)){
                                                self.taskViewModel.SetExpiredTrailAgain()
                                            }
                                        }
                                    })
                            {
                                Text("X").font(.system(size: 20)).foregroundColor(Color.black)
                            }
                            Spacer()
                        }
                    }
                }
                else{
                    
                    Text(!self.taskViewModel.errorPurchase ? "Processing, please wait for the window prompt..." : "It Seems Like Something Went Wrong, Please Try Again:").foregroundColor(Color.blue).font(Font.custom("MarkerFelt-Wide", size: 26)).bold()//.onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 6) {withAnimation(.ripple2()){ self.firstTry=false}} }
                     Spacer()
                    
                            
                                Button(action:{
                                    self.taskViewModel.errorPurchase=false
                                    self.firstTry=true
                                    self.press=false
                                    self.presentPayWall=true
                                    
                                      // self.taskViewModel.retrieveSubscriptionsInfo()
                                   })
                                      {
                                          
                                          Text("Choose a Subscription Plan").frame(width:240,height:70).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                                          
                                   }.padding().sheet(isPresented: self.$presentPayWall)
                                   {
                                       
                                       PayWallSubscriptions(taskViewModel: self.taskViewModel,press:self.$press,presentPayWall:self.$presentPayWall)
                                       
                                }.isHidden(!self.taskViewModel.errorPurchase)
                        
                    
                }
                
                /* Button(action:{self.taskViewModel.SetAccessTest()})
                   {
                       
                       Text("Full Access Test").frame(width:240,height:70).foregroundColor(Color.white).background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                       
                }.padding()*/
                
                
                
            }//.disabled(self.press)
            
            
            
            
            
            }.alert(isPresented: self.$showAlert) {
        
               switch self.alertType{
                   case 1:
                   return Alert(title: Text("Checking"),
                                    message: Text("\nPlease Wait..."),
                                    dismissButton: .default(Text("OK")))
                   case 3:
                   return Alert(title: Text("Subscription Restored Successfully"),
                                    message: Text("\nAuto Task Is Ready For Full Functional Use !"),
                                    dismissButton: .default(Text("OK")))
                   case 4:
                   return Alert(title: Text("Couldn't Find an Active Subscription"),
                                    message: Text("\nCouldn't find any active subscription related to your Apple ID."),
                                    dismissButton: .default(Text("OK")))
                   case 5:
                   return Alert(title: Text("Are You Sure ?"),
                                    message: Text("\nIn expired trail mode you can not use Auto Task's Auto Schedule, but only view your existing assignments\n\n In order to use Auto Task with full functionality, please choose a subscription plan."),
                                    primaryButton: .default(Text("Join Auto Task !")){self.presentPayWall=true}, secondaryButton: .default(Text("Return to Expired Trail Mode") ){
                                        withAnimation(.easeInOut(duration: 0.6)){
                                            self.taskViewModel.SetExpiredTrailAgain()
                                            self.showAlert=false
                                        }
                                        
                                    })
                    
                   default:
                       return Alert(title: Text("Error"),
                        message: Text("Error"),
                       dismissButton: .default(Text("OK")))
                }
           
           }
    }
}*/

/*struct PayWall_Previews: PreviewProvider {
    static var previews: some View {
        PayWall()
    }
}*/
