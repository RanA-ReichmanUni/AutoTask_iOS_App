//
//  MainViewRouter.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MainViewRouter : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "PageViewController1" {
                PageViewController1()
            } else if viewRouter.currentPage == "MainUI2" {
                MainUI2()
            }
        }
    }
}

struct MainViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        MainViewRouter().environmentObject(ViewRouter())
    }
}
