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
}

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
                            
                       
                                Text("By using the application you indicate that you agree to the application ").font(.system(size: 10))
                                Button(action:{UIApplication.shared.open(URL(string: self.page.privacyLinkAttached!)!)})
                                {
                                    Text("privacy policy").font(.system(size: 10))
                                    
                                }
                            
                            
                        }
                    }
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}
