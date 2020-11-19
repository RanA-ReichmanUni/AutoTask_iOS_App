//
//  PageViewController.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct PageViewController1: View {
    @ObservedObject var taskViewModel:TaskViewModel
    @State var currentPage=0
    @State var pages=[
        IntroPage(imageName:"robotHand",title:"Here To Help",description:"Auto Task is here to help you relieve the heavy stress from your student shoulders", privacyLinkAttached: nil),
                      IntroPage(imageName:"scheduleAddAndForget",title:"Add And Forget",description:"Use Auto Task to auto schedule your tasks inside your complicated schedule", privacyLinkAttached: nil),
                      IntroPage(imageName:"repeatedActivities",title:"Planning Your Tasks In Accordance With Your Own Schedule",description:"Before using auto schedule, insert your repeated activities such as: college classes, work, personal actvities and more... \nAuto Task will plan your new tasks in accordance with your fixed schedule", privacyLinkAttached: nil),
                      IntroPage(imageName:"options31",title:"The Controlls Are In Your Hands",description:"Chose from multiple avilable intelligent algortihms designed for your needs", privacyLinkAttached: nil),
                      IntroPage(imageName:"easy2",title:"Experience The Easier Way",description:"Try Auto Task For Free Without a Subscription Comitment and See How It Improve Your Work Experience. \nOnce You Reached the Limit Of Use, We Will Let You Know About Auto Task Fair Subscription Plans.",privacyLinkAttached:"https://auto-task-automatic.flycricket.io/privacy.html")]
    
    @State var buttonControl=false
    @State var finished=false
    @State var showPrivacyAgreement=false
    @State var isVersion13=false
    
    func setDescriptionTextByVersion()
    {
        if #available(iOS 13.3, *) {
            // use UICollectionViewCompositionalLayout
        } else {
            // show sad face emoji
            
            self.pages=[
                IntroPage(imageName:"robotHand",title:"Here To Help",description:"Auto Task is here to help you relieve the heavy stress from your student shoulders", privacyLinkAttached: nil),
                              IntroPage(imageName:"scheduleAddAndForget",title:"Add And Forget",description:"Use Auto Task to auto schedule your tasks inside your complicated schedule", privacyLinkAttached: nil),
                              IntroPage(imageName:"repeatedActivities",title:"In Accordance With Your Own Schedule",description:"Before using auto schedule, insert your repeated activities such as: college classes, work and more... \nAuto Task will plan your new tasks in accordance with your fixed schedule", privacyLinkAttached: nil),
                              IntroPage(imageName:"options31",title:"The Controlls Are In Your Hands",description:"Chose from multiple avilable intelligent algortihms designed for your needs", privacyLinkAttached: nil),
                              IntroPage(imageName:"easy2",title:"Experience The Easier Way",description:"Try Auto Task For Free Without a Subscription Comitment. \nOnce You Reached the Limit Of Use, We Will Let You Know About Auto Task Fair Subscription Plans.",privacyLinkAttached:"https://auto-task-automatic.flycricket.io/privacy.html")]
        }
    }
    
    func isVersion13Checker() -> Bool
    {
        if #available(iOS 13.3, *) {
            // use UICollectionViewCompositionalLayout
            return false
        }
        else{
            return true
        }
    }
    
    var body: some View {
        
       GeometryReader { geometry in
        if(!self.finished)
        {
        VStack{
   
              /*  PagingScrollView(activePageIndex: self.$currentPage,
                                 itemCount: self.pages.count,
                                 pageWidth: geometry.size.width,
                                 tileWidth: geometry.size.width,
                                 tilePadding: 0) {
                    ForEach (0 ..< self.pages.count) { index in
                        IntroPageView(page: self.pages[index])
                    }
                }*/
            if(self.isVersion13Checker())
            {
                IntroPageViewiOS13(page: self.pages[self.currentPage])
                    .transition(AnyTransition.pageTransition)
                        .id(self.currentPage).frame(width:geometry.size.width)
            }
            else{
                IntroPageView(page: self.pages[self.currentPage])
            .transition(AnyTransition.pageTransition)
                .id(self.currentPage)
            }
            HStack {
                PageControl(numberOfPages: self.pages.count, currentPageIndex: self.$currentPage)
                               
                Spacer()
                    if(self.currentPage != 0)
                    {
                    Button(action: {
                       withAnimation (.easeInOut(duration: 1.0)) {
                           
                            self.currentPage = (self.currentPage - 1)%self.pages.count
                            
                        }
                       
                    }) {
                        
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Circle().fill(Color.blue))
                    }
                }
                Button(action: {
                   withAnimation (.easeInOut(duration: 1.0)) {
                       if(self.currentPage == self.pages.count-1)
                       {
                        
                        
                        self.showPrivacyAgreement=true
                        //self.finished=true
                        
                       }
                       else{
                            self.currentPage = (self.currentPage + 1)%self.pages.count
                        }
                        
                                                    
                    }
                   
                }) {
                       if(self.currentPage == self.pages.count-1)
                         {
                             ZStack{
                                 RoundedRectangle(cornerRadius: 20).fill(Color.purple).frame(width:80,height:50)
                                Text("Done !").foregroundColor(Color.white).font(.system(size:26))
                             }
                         }else{
                             
                        
                             Image(systemName: "arrow.right")
                             .font(.largeTitle)
                             .foregroundColor(Color.white)
                             .padding()
                             .background(Circle().fill(Color.blue))
                         }
                }
            }
            .padding()
        }
        }
        else{
            
            MainUI2(taskViewModel:self.taskViewModel)
        }
       }.alert(isPresented:self.$showPrivacyAgreement)
       {
        
        return Alert(title: Text("Privacy Policy Agreement"), message: Text("\nBy using the application and clicking 'I Agree' you indicate that you read and agree to the application privacy policy linked in the previous view. /n/nclick 'Back' to read the privacy policy linked in the previous view."), primaryButton: .default(Text("I Agree")) {
                                                                                                     
                                 withAnimation(.easeInOut){
                                    UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                                    UserDefaults.standard.set(true, forKey: "userAgreedToPrivacyPolicy")
                                      //Check if the app installed before and cancel trail if it was
                                  /* if(!self.taskViewModel.checkIsAtInstalledBefore())
                                      {
                                          self.taskViewModel.setInstallIdToKeychain()
                                      }*/
                                    self.taskViewModel.SetOnceTimeObserver()
                                    self.finished=true}
                                                            
            }, secondaryButton: .cancel(Text("Back")))
       
     
       }.onAppear{self.setDescriptionTextByVersion()}
    }
}



extension AnyTransition {
    static var pageTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
