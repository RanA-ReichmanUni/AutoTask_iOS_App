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
                      IntroPage(imageName:"robotHand",title:"Here To Help",description:"RoboTask is here to help you relieve the heavy stress from your student shoulders"),
                      IntroPage(imageName:"sitting",title:"Add And Forget",description:"Use RoboTask to auto plan your many courses tasks inside your complicated schedule"),
                      IntroPage(imageName:"sitting",title:"Planning Your Tasks According To Your Own Schedule",description:"Before using auto schedule, insert your regular personal activties tasks, colleague classes, personal actvities and more... \nRoboTask will plan your new tasks according to your schedule"),
                      IntroPage(imageName:"sitting",title:"The Controlls Are In Your Hands",description:"Chose from multiple avilable intelligent algortihms designed for your needs"),
                      IntroPage(imageName:"robotHand",title:"Free To Experience",description:"Try Auto Task For Free Without A Subscription Comitment, And See How It Improves Your Work Experience. \nOnce You Reached The Limit Of Use, We Will Let You Know About Auto Task Fair Subscription Plans.")
    
    ]
    @State var buttonControl=false
    @State var finished=false
    
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
            IntroPageView(page: self.pages[self.currentPage])
            .transition(AnyTransition.pageTransition)
            .id(self.currentPage)
            
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
                        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                        
                        //Check if the app installed before and cancel trail if it was
                      if(!self.taskViewModel.checkIsAtInstalledBefore())
                        {
                            self.taskViewModel.setInstallIdToKeychain()
                        }
                        
                        self.finished=true
                        
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
        }
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
