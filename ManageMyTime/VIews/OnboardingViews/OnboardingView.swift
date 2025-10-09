//
//  OnboardingView.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "meditating")),
        UIHostingController(rootView: Subview(imageString: "skydiving")),
        UIHostingController(rootView: Subview(imageString: "sitting")),
        UIHostingController(rootView: Subview(imageString: "sitting"))
    ]
    
    var titles = ["Here To Help", "Add And Forget", "Planning According To Your Own Schedule","Control The Schedule Process"]
    
    var captions =  ["RoboTask is here to help you relieve the stress from your student shoulders", "Use RoboTask to auto plan your many courses tasks inside your complicated schedule", "Before using auto schedule, insert your regular personal activties tasks, colleague classes, personal actvities and more... RoboTask will plan your new tasks according to your schedule","Multiple intelligent algortihms avilable for your needs, chose whatever fits best for you"]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                PageViewController(currentPageIndex: self.$currentPageIndex, viewControllers: self.subviews)
                  
                ZStack{
                Group {
                    VStack{
                  
                    Text(self.titles[self.currentPageIndex])
                        .font(.title)
                        
                        Text(self.captions[self.currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                       
                    .lineLimit(nil)
                    }
                }
                    .padding()
                   
                    ZStack(alignment: .bottomTrailing) {
                      PageControl(numberOfPages: self.subviews.count, currentPageIndex: self.$currentPageIndex)
                  
                    Button(action: {
                        if self.currentPageIndex+1 == self.subviews.count {
                            self.currentPageIndex = 0
                        } else {
                            self.currentPageIndex += 1
                        }
                    }) {
                        ButtonContent()
                    }
               }
                    .padding()
                }
            }
        }
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .padding()
        .background(Color.orange)
        .cornerRadius(30)
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
#endif
