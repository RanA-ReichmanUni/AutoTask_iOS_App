//
//  RestrictedDayUI.swift
//  ManageMyTime
//
//  Created by רן א on 17/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct RestrictedDayUI: View {
    
    @State private var flipIt=false
    @State private var numberOfControlls = 1
    @State private var scrollViewID = UUID()
    
    var body: some View {
        VStack{
           Button(action: {
               self.numberOfControlls += 1
            self.flipIt.toggle()
            self.scrollViewID = UUID()
           }) {
              Spacer()
               Text("Add      ")
             
           }
            Spacer()
            
    
        
            RestrictedSpaceView(numberOfControlls: $numberOfControlls,scrollViewID:self.scrollViewID)


          
   
                    
            
        
        }
        
    }
}

struct RestrictedDayUI_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedDayUI()
    }
}
