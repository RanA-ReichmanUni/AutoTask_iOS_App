//
//  IntroPageView.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct IntroPage {
    let imageName: String
    let title: String
    let description: String
    let privacyLinkAttached:String?
    let agreementLinkAttached:String?
}

struct IntroPageViewiOS13: View {
    let page: IntroPage
    var body: some View {
        GeometryReader{geometry in
        VStack {
            Spacer()
            
            Image(self.page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit).frame(height:geometry.size.height*0.6)
            
          
            
            Group {
                HStack {
                   
                    Text(self.page.title).font(.system(size: 24))
                        .font(.title)
                        .foregroundColor(.blue).frame(height:geometry.size.height*0.15).padding(.leading,10)
                    Spacer()
                }
                
                HStack {
                    VStack{
                        Text(self.page.description).font(.system(size: 18)).frame(width:geometry.size.width*0.9,height:geometry.size.height*0.2)
                       Spacer()
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
                                        Text("Application Terms and Conditions").font(.system(size: 10))
                                        
                                    }
                                
                            }
                            
                            
                        }
                    }
                    }
                    if(self.page.privacyLinkAttached == nil)
                    {
                        Spacer()
                    }
                }
            }
           
        }
        }
    }
}
