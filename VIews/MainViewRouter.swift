//
//  MainViewRouter.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MainViewRouter : View {
    @ObservedObject var taskViewModel:TaskViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "PageViewController1" {
                PageViewController1(taskViewModel:self.taskViewModel)
            } else if viewRouter.currentPage == "MainUI2" {
                MainUI2(taskViewModel:self.taskViewModel)
            }
        }
    }
}

/*struct MainViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        MainViewRouter().environmentObject(ViewRouter())
    }
}
*/
