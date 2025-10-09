//
//  SceneDelegate.swift
//  ManageMyTime
//
//  Created by רן א on 21/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static let taskViewModel = TaskViewModel()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // ✅ שלב 1: קבלת ה־context בבטחה מתוך ה־AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("לא ניתן לגשת ל-AppDelegate")
        }
        let context = appDelegate.persistentContainer.viewContext

        // ✅ שלב 2: העברת ה־context ל־TaskViewModel (כדי למנוע קריסת EXC_BAD_ACCESS)
        SceneDelegate.taskViewModel.attach(context: context)

        // ✅ שלב 3: קריאת פונקציות קיימות שלך
        SceneDelegate.taskViewModel.retrieveAllTasks()
        // SceneDelegate.taskViewModel.retrieveSubscriptionsInfo()

        // ✅ שלב 4: יצירת ה־MainViewRouter עם סביבה תואמת
        let mainViewRouter = MainViewRouter(taskViewModel: SceneDelegate.taskViewModel)
            .environmentObject(ViewRouter())
            .environment(\.managedObjectContext, context) // ← הזרקת ה־context לסביבת SwiftUI

        // ✅ שלב 5: שימוש ב־UIHostingController
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: mainViewRouter)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // שמירת שינויים בעת מעבר לרקע
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
