//
//  Source.swift
//  ManageMyTime
//
//  Created by רן א on 23/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct Source: View {
    
    @State var showMenu = false
    @State var showWeeklySchedule=false
    @State var showTesting=false
    @State var showTasks=false
    @ObservedObject var taskViewModel = TaskViewModel()
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu,showWeeklySchedule:self.$showWeeklySchedule,showTesting:self.$showTesting, showTasks: self.$showTasks, taskViewModel: self.taskViewModel).onAppear{self.taskViewModel.retrieveAllTasks()}
                        .frame(width: geometry.size.width, height: geometry.size.height).overlay(
                            HStack{
                                MenuView(showWeeklySchedule:self.$showWeeklySchedule,showTesting:self.$showTesting, showMenu: self.$showMenu, showTasks: self.$showTasks)
                                .frame(width: geometry.size.width/2,alignment: .leading)
                                Spacer()
                            }
                        
                            .transition(.move(edge: .leading))   )
                        //.offset(x: self.showMenu ? geometry.size.width/2 : 0)
                       // .disabled(self.showMenu ? true : false)
                
                }
                    .gesture(drag)
            }
                .navigationBarTitle("Side Menu", displayMode: .inline)
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.showMenu.toggle()
                            
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                           .resizable()
                            .frame(width: 35, height: 20)
                    }
                ))
        }
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @Binding var showWeeklySchedule:Bool
    @Binding var showTesting:Bool
    @Binding var showTasks:Bool
    @ObservedObject var taskViewModel:TaskViewModel
    
    var body: some View {
        VStack{
         
            if(showWeeklySchedule)
            {
                ScheduleViewRow(taskViewModel:self.taskViewModel).transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
            }
            if(showTesting)
             {
               /* ButtonTestingView().transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)*/
             }
            if(showTasks)
            {
                TaskList(taskViewModel:self.taskViewModel).transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)).padding(.bottom,10)
            }
            
        }.onTapGesture {
            withAnimation{
                self.showMenu=false
            }
        }
    }
}

struct Source_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
