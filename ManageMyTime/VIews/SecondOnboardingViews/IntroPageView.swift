//
//  IntroPageView.swift
//  AutoTask
//
//  Created by רן א on 19/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct IntroPageView: View {
    let page: IntroPage
    var body: some View {
        VStack {
            Spacer()
            Image(self.page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Group {
                HStack {
                    Text(self.page.title).font(.system(size: 30))
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }
                HStack {
                    VStack{
                    Text(self.page.description).font(.system(size: 18))
                       
                    if(self.page.privacyLinkAttached != nil)
                    {
                        VStack{
                                //Spacer()
                       
                           
                                Text("By using the application you indicate that you read and agree to the ").font(.system(size: 10))
                            HStack{
                                Button(action:{UIApplication.shared.open(URL(string: self.page.privacyLinkAttached!)!)})
                                {
                                    Text("Privacy Policy").font(.system(size: 10))
                                    
                                }
                               Text(" and ").font(.system(size: 10))
                                    Button(action:{UIApplication.shared.open(URL(string: self.page.agreementLinkAttached!)!)})
                                    {
                                        Text("Application Terms").font(.system(size: 10))
                                        
                                    }
                                
                            }
                            
                            
                        }.padding(.top,20)
                    }
                    }
                    if(self.page.privacyLinkAttached == nil)
                    {
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}
