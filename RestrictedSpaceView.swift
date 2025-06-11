//
//  RestrictedSpaceView.swift
//  ManageMyTime
//
//  Created by רן א on 29/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct RestrictedSpaceView: View {
    @State private var age = 18
   // @State private var selection = 1
   
    @Binding var numberOfControlls:Int
 var scrollViewID:UUID
  
    @State var data: [(String, [String])] = [
         ("Hour", Array(0...20).map { "\($0)" }),
         ("Minutes", Array(0...59).map { "\($0)" })
     ]
     @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    
    var body: some View {

        
         ScrollView {
       
            
     
            
          ForEach(0 ..< numberOfControlls, id: \.self) { num in
            VStack{
                HStack{
                    
                    VStack(alignment:.leading){
                   
              
                        
                    PickerView()
                  
                
                    }
                    Button(action: {
                                                                            
                    }) {
                      VStack{
                          Text("Delete").foregroundColor(Color.red)
                     Image(systemName: "trash").foregroundColor(Color.red)
                        
                      }
                        Spacer()
                    }
                    
                    
                     
            }
                
                Spacer()
                 Divider()
                
            }
           
              /* MultiPicker(data: self.data, selection: self.$selection,stringValue1: "Hours",stringValue2:"                        Minutes",stringValue3:"").frame(height: 110).padding()*/
            }
         
          
            
        }.id(self.scrollViewID)
        
    }
}

/*struct RestrictedSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedSpaceView(numberOfControlls: 1)
    }
}*/

extension View {
    public func flip() -> some View {
        return self
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .bottom)
    }
}
