//
//  TaskController.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftUI
import Purchases

enum UUIDError: Error {
      case notConfirmedToUUID
      case badPassword
      
  }
  
  enum DatabaseError: Error {
        case taskCanNotBeScheduledInDue
        case newRestrictedSpaceContradictionCantRescheduleTasks
        case someTaskHaveBeenMoved
    }

enum DateBoundsError: Error {
      case dueDateIsInPastTime

      
  }

enum PaymentError: Error {
    case TrailEndReached
    case RestoredSuccessfully
    case NoPreviousSubscription
}

enum DaysOfTheWeek:String {
          
        case Sunday
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
 
}

class TaskViewModel : ObservableObject
{
    
    
    private var viewModelTask : Task?
    
    @Published var allTasks = [Task]()
    
    @Published var taskName : String
    
    @Published var importance : String
    
    @Published var startTimeHour : String
    @Published var startTimeMinutes : String
    
    @Published var endTimeMinutes : String
    @Published var endTimeHour : String
    
    @Published var date : CustomDate
    
    @Published var asstimatedWorkTimeHour : String
    @Published var asstimatedWorkTimeMinutes : String
    
    @Published var dueDate : Date
    
    @Published var notes : String
    
    @Published var id : UUID
    
    @Published var color : Color
    //@Published var color : Color
    @Published var firstTaskColor:Color
    
    @Published var allTasksPerHourInWeek = [TasksPerHourPerDayOfTheWeek]()
    
    @Published var latestDayChoiseIndex:Int
    
    private var didInit:Bool
  
    @Published var absoluteAllTasks:[Task]
    
    var taskModel = TaskModel()
    
    @Published var hoursRange:[Int]
    
    @Published var AvailableSubscriptions : [Subscription]
    
    @Published var SubscriptionTitles : [String]
    
    @Published var SubscriptionObjects : [SubscriptionObj]
    
    @Published var hasFullAccess:Bool
    
    @Published var trailEnded:Bool
    
    @Published var restoredSubscription:Bool
    
    @Published var failedRestoringSubscription:Bool
    
    @Published var returnedFromCall:Bool
    
    @Published var errorPurchase:Bool
    
    var overrideFullAccess:Bool
    
     init()
     {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                         
                         //We need to create a context from this container
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        taskName="Default"
        importance="Medium"
       // asstimatedWorkTime=Hour(context: managedContext)
        hoursRange=[]
        dueDate=Date()
        notes="None"
        //allTasks=[]
       // viewModelTask=Task()
      
        //color=Color(.systemTeal)
        id=UUID()
        color=Color.blue
        date=CustomDate(context: managedContext)
        firstTaskColor=Color.white
        latestDayChoiseIndex=0
        didInit=false
        absoluteAllTasks=[Task]()
        asstimatedWorkTimeHour="0"
        asstimatedWorkTimeMinutes="0"
        startTimeHour="0"
        startTimeMinutes="0"
        endTimeHour="0"
        endTimeMinutes="0"
        AvailableSubscriptions=[Subscription]()
        SubscriptionTitles=[String]()
        SubscriptionObjects=[SubscriptionObj]()
        hasFullAccess=false
        trailEnded=false
        restoredSubscription=false
        failedRestoringSubscription=false
        returnedFromCall=false
        errorPurchase=false
        overrideFullAccess=false
        
        date.day=0
        date.month=0
        date.year=0
        
        //retrieveAllTasks()
    
     }
    
    func DefaultRestoreSubscriptionValues()
    {
        self.restoredSubscription=false
        self.failedRestoringSubscription=false
    }
    func SetEndTrail()
    {
        UserDefaults.standard.set(true,forKey: "trailEnded")
        self.trailEnded=true
        
    }
    
    func SetOverrideFullAccess()
    {
        
        self.overrideFullAccess=true
        self.hasFullAccess=true
    }
    func getPurchaserInfo()
    {
              
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["Full Access"]?.isActive == true {
               // Unlock that great "pro" content
               self.hasFullAccess=true
                UserDefaults.standard.set(true, forKey: "nonSuspicious")
                UserDefaults.standard.set(true, forKey: "hasBeenSubscribed")
                UserDefaults.standard.set(0,forKey: "offlineClicks")
             }
            else if purchaserInfo?.entitlements["Full Access"]?.isActive == false{
                self.hasFullAccess=false
                 UserDefaults.standard.set(false, forKey: "nonSuspicious")
                UserDefaults.standard.set(31,forKey: "offlineClicks")
            }
            
            if (purchaserInfo == nil){
                
              /*  let numberOfClicks=UserDefaults.standard.integer(forKey: "offlineClicks")
                UserDefaults.standard.set(numberOfClicks+1,forKey: "offlineClicks")*/
                
               /* if(numberOfClicks+1 >= 10)
                {*/
                    self.hasFullAccess=false
                    UserDefaults.standard.set(false, forKey: "nonSuspicious")
               /* }*/
            }
            self.returnedFromCall=true
        }
    }
    func UpdateTrailEndStatus()
    {
        self.trailEnded=UserDefaults.standard.bool(forKey: "trailEnded")
    }
    
    func setInstallIdToKeychain(login: String="atinalrsus", pass: String="insalrdtr")
    {
        do{
           let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                   account: login,
                                                   accessGroup: KeychainConfiguration.accessGroup)


           // Save in keychain
           try passwordItem.savePassword(pass)
         } catch { print(error.localizedDescription) }
    }
    
    func setEndSubscription()
    {
        self.hasFullAccess=false
         UserDefaults.standard.set(false, forKey: "nonSuspicious")
         UserDefaults.standard.set(31,forKey: "offlineClicks")
        self.failedRestoringSubscription=true
    }
    
   func checkIsAtInstalledBefore(forUser user: String="atinalrsus") -> Bool  {
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: user,
                                                    accessGroup: KeychainConfiguration.accessGroup)
                    
            // Read password form Keychain
            let pass = try passwordItem.readPassword()
           
            if(pass=="insalrdtr")
            {
                SetEndTrail()
                return true
            }
            else{
                return false
            }
       
            
            } catch { print(error.localizedDescription)
                
                return false

            }
    
    
           
    }
       
    

    func DayStringToNumConverter(dayOfTheWeek:String) -> Int
       {
           switch dayOfTheWeek.lowercased() {
           case "sunday":
               return 0
           case "monday":
               return 1
           case "tuesday":
               return 2
           case "wednesday":
               return 3
           case "thursday":
               return 4
           case "friday":
               return 5
           case "saturday":
               return 6
           default:
               return 0
           }
           
          
           
       }
    
    func completedToggle(tasdkId:UUID)
    {
        self.taskModel.completedToggle(taskId: tasdkId)
    }
    func getFirstTaskColor()
    {
        
        self.firstTaskColor=taskModel.getFirstTaskColor()
       
    }
    
    func getTaskColor(task:Task) -> Color
    {
        
        return taskModel.getTaskColor(task: task)
        
    }
    
    func DestroyAll()
    {
        
        taskModel.DestroyAll()
        allTasks=[]
        
    }
  
    
    func createTask(taskName:String,importance:String,workTimeHours:String,workTimeMinutes:String,dueDate:Date,notes:String,color:Color=Color.green,difficultyIndex:Int,notificationIndex:Int) throws
    {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.taskName=taskName
        self.importance=importance
        self.dueDate=dueDate
        self.notes=notes
       // asstimatedWorkTime=Hour(context: managedContext)
        self.asstimatedWorkTimeHour=workTimeHours
        self.asstimatedWorkTimeMinutes=workTimeMinutes
        
        let workTime=Hour(context: managedContext)
            workTime.hour=Int(workTimeHours) ?? 0
            workTime.minutes=Int(workTimeMinutes) ?? 30
        
        var difficultyPick="average"
        
        
        switch difficultyIndex {
        case 0:
            difficultyPick=difficultyLevel.difficult.rawValue
        case 1:
            difficultyPick=difficultyLevel.average.rawValue
        case 2:
            difficultyPick=difficultyLevel.easy.rawValue
        default:
            difficultyPick=difficultyLevel.average.rawValue
        }
        
        var notificationPick=0
        
        switch notificationIndex {
        case 0:
            notificationPick = -1
        default:
            notificationPick=notificationIndex-1
        }
        
        let numberOfTasks=UserDefaults.standard.integer(forKey: "numberOfTasks")
                  
        if(numberOfTasks>=7 && !self.hasFullAccess)
          {
            
            if(!UserDefaults.standard.bool(forKey: "reachedTrailAlert"))
            {
              UserDefaults.standard.set(true, forKey: "reachedTrailAlert")
            }
            
              throw PaymentError.TrailEndReached
            
          }
        
        do{
            
          
  
            try taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: workTime,dueDate: dueDate,notes: notes,color:color,difficulty:difficultyPick,notificationFactor:notificationPick)
           
            if(numberOfTasks<9)
            {
                UserDefaults.standard.set(numberOfTasks+1, forKey: "numberOfTasks")
            }
        }
     
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
    }
    
    func StringRangeCreator(start:Int,end:Int) -> [String]
    {
        var stringValues=[String]()
        stringValues.append("None")
        for num in start...end
        {
            stringValues.append(String(num))
   
            
        }
        
        return stringValues
   
    }
  
    func feedAllFreeSpacesTest()
    {
        let coreManagment=Core()
        
        coreManagment.feedSpacesToMergeFreeSpaces()
        
    }
    
   /* func SetAccessTest()
    {
        self.hasFullAccess=true
    }*/
    

    
    func CheckSubscription()
    {
        //Gives grace time for using the app without autoschedules for 20 clicks for main stack
        if(UserDefaults.standard.integer(forKey: "numberOfEndTrailClicks") >= 5 && !self.hasFullAccess)
          {
              self.SetEndTrail()
          }
          
          
        if(UserDefaults.standard.bool(forKey: "reachedTrailAlert") && !self.hasFullAccess)
          {
              let numberOfEndTrailClicks=UserDefaults.standard.integer(forKey: "numberOfEndTrailClicks")
              UserDefaults.standard.set(numberOfEndTrailClicks+1,forKey: "numberOfEndTrailClicks")
          }
        
        if(!self.overrideFullAccess)
        {
            Purchases.shared.restoreTransactions { (purchaserInfo, error) in
                if purchaserInfo?.entitlements["Full Access"]?.isActive == true {
                   // Unlock that great "pro" content
                   self.hasFullAccess=true
                    UserDefaults.standard.set(true, forKey: "nonSuspicious")
                    UserDefaults.standard.set(true, forKey: "hasBeenSubscribed")
                    UserDefaults.standard.set(0,forKey: "offlineClicks")
                 }
                else if purchaserInfo?.entitlements["Full Access"]?.isActive == false{
                    self.hasFullAccess=false
                     UserDefaults.standard.set(false, forKey: "nonSuspicious")
                    UserDefaults.standard.set(16,forKey: "offlineClicks")

                }
                
                if (purchaserInfo == nil){
                    
                    let numberOfClicks=UserDefaults.standard.integer(forKey: "offlineClicks")
                    UserDefaults.standard.set(numberOfClicks+1,forKey: "offlineClicks")
                    
                    if(numberOfClicks+1 >= 15)
                    {
                        self.hasFullAccess=false
                        UserDefaults.standard.set(false, forKey: "nonSuspicious")
                    }
                }
                self.returnedFromCall=true
            }
        }
        
        
    }
    
    func TrailModeCheckSubscription()
    {
        
        
        Purchases.shared.restoreTransactions { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["Full Access"]?.isActive == true {
               // Unlock that great "pro" content
               self.hasFullAccess=true
                UserDefaults.standard.set(true, forKey: "nonSuspicious")
                UserDefaults.standard.set(true, forKey: "hasBeenSubscribed")
                UserDefaults.standard.set(0,forKey: "offlineClicks")
                self.SetEndTrail()
                
                self.restoredSubscription=true
                
                
             }
            else if purchaserInfo?.entitlements["Full Access"]?.isActive == false{
                self.hasFullAccess=false
                 UserDefaults.standard.set(false, forKey: "nonSuspicious")
                 UserDefaults.standard.set(31,forKey: "offlineClicks")
                self.failedRestoringSubscription=true
            }
            
            if (purchaserInfo == nil){
           
                
                
                let numberOfClicks=UserDefaults.standard.integer(forKey: "offlineClicks")
                UserDefaults.standard.set(numberOfClicks+1,forKey: "offlineClicks")
                
                if(numberOfClicks+1 >= 30)
                {
                    self.hasFullAccess=false
                    UserDefaults.standard.set(false, forKey: "nonSuspicious")
                    
                }
                
                 self.failedRestoringSubscription=true
                
            }
        }
        
       
        
    }
    
    
    func MakeAPurchase(package:Purchases.Package)
    {
        if Purchases.canMakePayments() {
            // User is authorized to make payments
       
            Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
              if purchaserInfo?.entitlements["Full Access"]?.isActive == true {
                // Unlock that great "pro" content
                self.hasFullAccess=true
                 UserDefaults.standard.set(true, forKey: "nonSuspicious")
                 UserDefaults.standard.set(0,forKey: "offlineClicks")
                 UserDefaults.standard.set(true, forKey: "hasBeenSubscribed")
                
              }
                
                if(!(error?.localizedDescription.isEmpty ?? true))
                {
                    self.errorPurchase=true
                }
                self.SubscriptionObjects=[]
            }
        }
        
        
        
    }
    
    
   
    
    
    func retrieveSubscriptionsInfo()
    {
        
        Purchases.shared.offerings { (offerings, error) in
            self.SubscriptionObjects=[]
            self.SubscriptionTitles=[]
            self.AvailableSubscriptions=[]
            if let offerings = offerings{
                
                let offer=offerings.current
                let packages = offer?.availablePackages
                
                guard packages != nil else{
                    return
                }
                
                for i in 0...packages!.count-1 {
                    
                    let package = packages![i]
                    
                    
                    
                    let product = package.product
                    
                    
                    //product.localizedTitle - for appstoreconnect loclized title
                    
                    var title = product.localizedTitle
                    let price = product.price
                    
                
                   
                    var currency=""
                    var currencySymbol=""
                    if(product.priceLocale.currencyCode != nil)
                    {
                        currency=product.priceLocale.currencyCode!
                        
                        let locale = NSLocale.autoupdatingCurrent
                        
                        currencySymbol=currency
                    
                    
                        if(locale.currencySymbol != nil && locale.currencyCode != nil)
                       {
                            if(locale.currencyCode! == currency)
                            {
                                currencySymbol=locale.currencySymbol!
                            }
                       }
                        
                        if(currencySymbol=="¤")
                        {
                            currencySymbol=currency
                        }
                         
                        
                    }
                    
                    var duration=""
                    let subscriptionPeriod = product.subscriptionPeriod
                    
                    switch subscriptionPeriod!.unit {
                    case SKProduct.PeriodUnit.year:
                        duration="\(subscriptionPeriod!.numberOfUnits) Year"
                    default:
                        duration = ""
                    }
                    
                    self.AvailableSubscriptions.append(Subscription(title: title, price: price.description, duration: duration))
                    
                    if(product.productIdentifier=="at_3_1y_1w0")
                    {
                        
                       
                        title="7 Days Free Trail For New Users \n\n"
                        
                         self.SubscriptionTitles.append(title + "When Trail Ends - Introductory Price:\nFirst Year" + " At " + price.description+" "+currencySymbol)
                        self.SubscriptionObjects.append(SubscriptionObj(text: title + "When Trail Ends - Introductory Price:\nAnnual Subscription For A Year" + " At " + price.description+" "+currencySymbol+" !", packageObject: package))
                            
                    }
                    else if(product.productIdentifier=="at_3_1y")
                    {
                        
                        title="Introductory Price - \n"
                                              
                       self.SubscriptionTitles.append(title + "\nFirst Year" + " At " + price.description+" "+currencySymbol)
                      self.SubscriptionObjects.append(SubscriptionObj(text: title + "\nAnnual Subscription For A Year" + " At " + price.description+" "+currencySymbol, packageObject: package))
                        
                    }
                    else{
                        self.SubscriptionTitles.append(title + " " + duration + " " + price.description+" "+currencySymbol)
                        
                        self.SubscriptionObjects.append(SubscriptionObj(text: title + " " + duration + " " + price.description+" "+currencySymbol, packageObject: package))
                    }
                }
            }
        }
    
        
        
        
    }
    
  func autoFillTesting() throws
  {
        do{
            try taskModel.autoFillTesting()
        
        }
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
    
  }

    func retrieveTask(taskID : String) throws
      {
        let taskUUID = UUID(uuidString: taskID) ?? UUID()
    
       
        
       if taskUUID.uuidString != taskID
       {
            throw UUIDError.notConfirmedToUUID
       }
        

         viewModelTask=taskModel.retrieveTask(taskID: taskUUID)
          
        self.taskName=viewModelTask!.taskName
        self.importance=viewModelTask!.importance!
        //self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask!.dueDate
        self.notes=viewModelTask!.notes!
        self.color=taskModel.getTaskColor(color:viewModelTask!.color!)
        
        SetViewHourStandard(startTime: viewModelTask!.startTime!, endTime: viewModelTask!.endTime!, asstimatedWorkTime: viewModelTask!.asstimatedWorkTime)
        //taskModel.retrieveAllTasks()
          
      }
    
    func AdjustViewHourStandard(value:Int) -> String
    {
        if(String(value).count==1)
            {
               return "0"+String(value)
            }
            else{
                return String(value)
            }
    }
    
    func SetViewHourStandard(startTime:Hour,endTime:Hour,asstimatedWorkTime:Hour)
    {
        
        if(String(startTime.hour).count==1)
        {
            self.startTimeHour="0"+String(startTime.hour)
        }
        else{
            self.startTimeHour=String(startTime.hour)
        }
        
        
        if(String(startTime.minutes).count==1)
          {
              self.startTimeMinutes="0"+String(startTime.minutes)
          }
          else{
              self.startTimeMinutes=String(startTime.minutes)
          }
        
        
        
        
        
        if(String(endTime.hour).count==1)
         {
             self.endTimeHour="0"+String(endTime.hour)
         }
         else{
             self.endTimeHour=String(endTime.hour)
         }
        
        if(String(endTime.minutes).count==1)
        {
            self.endTimeMinutes="0"+String(endTime.minutes)
        }
        else{
            self.endTimeMinutes=String(endTime.minutes)
        }
        
        
        if(String(asstimatedWorkTime.hour).count==1)
           {
               self.asstimatedWorkTimeHour="0"+String(asstimatedWorkTime.hour)
           }
           else{
               self.asstimatedWorkTimeHour=String(asstimatedWorkTime.hour)
           }
          
          if(String(asstimatedWorkTime.minutes).count==1)
          {
              self.asstimatedWorkTimeMinutes="0"+String(asstimatedWorkTime.minutes)
          }
          else{
              self.asstimatedWorkTimeMinutes=String(asstimatedWorkTime.minutes)
          }
        
        
    }
    
    func intialValuesSetup()
    {
        
        taskModel.intialValuesSetup()
        
    }
    func UpdateStartEndDay(dayStartTimeHour:String,dayStartTimeMinutes:String,dayEndTimeHour:String,dayEndTimeMinutes:String)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
              
       
        let managedContext = appDelegate.persistentContainer.viewContext
              
        
        let startOfDay=Hour(context: managedContext)
            startOfDay.hour=Int(dayStartTimeHour) ?? 7
            startOfDay.minutes=Int(dayStartTimeMinutes) ?? 0
        let endOfDay=Hour(context: managedContext)
            endOfDay.hour=Int(dayEndTimeHour) ?? 22
            endOfDay.minutes=Int(dayEndTimeMinutes) ?? 0
        
        
        
        
        taskModel.UpdateStartEndDay(dayStartTime:startOfDay,dayEndTime:endOfDay)
    }
    
    func TempFuncForDate() -> Date{
        
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 10
        dateComponents.day = 25
      
        dateComponents.hour = Date().hour
        dateComponents.minute = Date().minutes

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        
        return someDateTime!
    }
    
    func SetSettingsValues(scheduleAlgorithimIndex:Int,scheduleDensityIndex:Int,breakPeriodsIndex:Int,animationStyleIndex:Int)
    {
       
        
     
        
        var scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        var scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
        var breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
        var animationStylePick=animationStyle.smooth.rawValue
        
        switch scheduleAlgorithimIndex {
        case 0:
            scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        case 1:
            scheduleAlgorithimPick=scheduleAlgorithm.optimal.rawValue
        case 2:
            scheduleAlgorithimPick=scheduleAlgorithm.advanced.rawValue
        case 3:
            scheduleAlgorithimPick=scheduleAlgorithm.earliest.rawValue
        case 4:
            scheduleAlgorithimPick=scheduleAlgorithm.latest.rawValue
        default:
            scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        }
        
        
        switch scheduleDensityIndex {
         case 0:
            scheduleDensityPick=scheduleDensity.verySpacious.rawValue
         case 1:
            scheduleDensityPick=scheduleDensity.spacious.rawValue
         case 2:
            scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
         case 3:
            scheduleDensityPick=scheduleDensity.dense.rawValue
         case 4:
            scheduleDensityPick=scheduleDensity.veryDense.rawValue
         case 5:
            scheduleDensityPick=scheduleDensity.extremelyDense.rawValue
         case 6:
            scheduleDensityPick=scheduleDensity.maximumCapacity.rawValue
         default:
             scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
         }
        
        
        switch breakPeriodsIndex {
           case 0:
              breakPeriodsPick=breakPeriods.fortyFiveMinutes.rawValue
           case 1:
              breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
           case 2:
              breakPeriodsPick=breakPeriods.twoHours.rawValue
           case 3:
              breakPeriodsPick=breakPeriods.threeHours.rawValue
           case 4:
              breakPeriodsPick=breakPeriods.fiveHours.rawValue
           case 5:
              breakPeriodsPick=breakPeriods.Continues.rawValue
           default:
               breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
           }
        
        switch animationStyleIndex {
             case 0:
                animationStylePick=animationStyle.smooth.rawValue
             case 1:
                animationStylePick=animationStyle.fast.rawValue
             case 2:
                animationStylePick=animationStyle.spring.rawValue
             default:
                animationStylePick=animationStyle.smooth.rawValue
             }
        
        
        self.taskModel.SetSettingsValues(scheduleAlgorithim: scheduleAlgorithimPick, scheduleDensity: scheduleDensityPick,breakPeriodsValue:breakPeriodsPick,animationStyleValue: animationStylePick)
        
        
    }
    
 
    
    func GetAnimationStyleSettings () -> String
    {
        return taskModel.GetAnimationStyleSettings()
        
    }
    func GetDayBoundsSettingsValues () -> [String]
   {
    let settingsObject=taskModel.getSettingsValues()
    
        return [String(settingsObject.dayStartTime.hour),String(settingsObject.dayStartTime.minutes),String(settingsObject.dayEndTime.hour),String(settingsObject.dayEndTime.minutes)]
    }
    
    func getSettingsValues () -> [Int]
    {
        let settingsObject=taskModel.getSettingsValues()
        
        var scheduleAlgorithmPick=0
        var scheduleDensityPick=2
        var breakPeriodsPick=1
        var animationStylePick=0
        
        switch settingsObject.scheduleAlgorithim {
        case scheduleAlgorithm.smart.rawValue:
            scheduleAlgorithmPick=0
        case scheduleAlgorithm.optimal.rawValue:
            scheduleAlgorithmPick=1
        case scheduleAlgorithm.advanced.rawValue:
            scheduleAlgorithmPick=2
        case scheduleAlgorithm.earliest.rawValue:
            scheduleAlgorithmPick=3
        case scheduleAlgorithm.latest.rawValue:
            scheduleAlgorithmPick=4
        default:
            scheduleAlgorithmPick=0
        }
        
        
        switch settingsObject.scheduleDensity {
            case scheduleDensity.verySpacious.rawValue:
                scheduleDensityPick=0
            case scheduleDensity.spacious.rawValue:
                scheduleDensityPick=1
            case scheduleDensity.mediumDensity.rawValue:
                scheduleDensityPick=2
            case scheduleDensity.dense.rawValue:
                scheduleDensityPick=3
            case scheduleDensity.veryDense.rawValue:
                scheduleDensityPick=4
            case scheduleDensity.extremelyDense.rawValue:
                scheduleDensityPick=5
            case scheduleDensity.maximumCapacity.rawValue:
                scheduleDensityPick=6
            default:
                scheduleDensityPick=2
            }
        
        switch settingsObject.breakPeriods {
                case breakPeriods.fortyFiveMinutes.rawValue:
                   breakPeriodsPick=0
                case breakPeriods.hourAndAHalf.rawValue:
                   breakPeriodsPick=1
                case breakPeriods.twoHours.rawValue:
                   breakPeriodsPick=2
                case breakPeriods.threeHours.rawValue:
                   breakPeriodsPick=3
                case breakPeriods.fiveHours.rawValue:
                   breakPeriodsPick=4
                case breakPeriods.Continues.rawValue:
                   breakPeriodsPick=5
                default:
                    breakPeriodsPick=1
                }
        switch settingsObject.animationStyle {
          case animationStyle.smooth.rawValue:
             animationStylePick=0
          case animationStyle.fast.rawValue:
             animationStylePick=1
          case animationStyle.spring.rawValue:
             animationStylePick=2
          default:
             animationStylePick=0
          }
        
        let settingsArray=[scheduleDensityPick,scheduleAlgorithmPick,breakPeriodsPick,animationStylePick]
        
        return settingsArray
        
    }
    
    func retrieveTask(taskName : String)
      {
        
        
        viewModelTask=taskModel.retrieveTask(taskName: taskName)
          
        self.taskName=viewModelTask!.taskName
        self.importance=viewModelTask!.importance!
        //self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask!.dueDate
        self.notes=viewModelTask!.notes!
        self.color=taskModel.getTaskColor(color: viewModelTask!.color!)
       
        SetViewHourStandard(startTime: viewModelTask!.startTime!, endTime: viewModelTask!.endTime!, asstimatedWorkTime: viewModelTask!.asstimatedWorkTime)
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveAllTasks()
    {
        if(latestDayChoiseIndex != 0)//Case there is an update from the view, we should load the previous choise (if exsits) and the default all tasks scenerio
        {
            GetDayTasksByIndex(index:latestDayChoiseIndex)
        }
        else{
            if(absoluteAllTasks.isEmpty)
            {
                absoluteAllTasks=taskModel.retrieveAllTasks()
                allTasks=absoluteAllTasks
            }
            else{
                allTasks=absoluteAllTasks
            }
        }
            
        
        
    }
    
    func GetAllTasks()
    {
        absoluteAllTasks=taskModel.retrieveAllTasks()
        print(absoluteAllTasks.count
        )
    }
    
    func UpdateAllTasks()
    {
        
        absoluteAllTasks=taskModel.retrieveAllTasks()
        
        if(latestDayChoiseIndex==0)
        {
            allTasks=absoluteAllTasks
        }
        
    }
    
    func RetrieveAllTasks() -> [Task]
      {
        
        var tasks=taskModel.retrieveAllTasks()
        
        tasks.sort {
                           ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                               ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                       }
        
          
          return tasks
          
              
          
          
      }
    
    func DayToIndexConverter() -> Int
    {
           
        switch Date().dayOfWeek()!.lowercased()
        {
                
            case "sunday":
                 return 1
            case "monday":
                 return 2
            case "tuesday":
                 return 3
            case "wednesday":
                 return 4
            case "thursday":
                 return 5
            case "friday":
                 return 6
            case "saturday":
                 return 7
            default:
                return 0
  
        }
        
    }
    
    func GetDayTasksByIndex(index:Int)
    {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        switch index {
        case 0:
            self.latestDayChoiseIndex=0
            retrieveAllTasks()
            
        case 1:
            self.latestDayChoiseIndex=1
            let dayName=DaysOfTheWeek.Sunday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
            
            
        case 2:
            self.latestDayChoiseIndex=2
            let dayName=DaysOfTheWeek.Monday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 3:
            self.latestDayChoiseIndex=3
            let dayName=DaysOfTheWeek.Tuesday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 4:
            self.latestDayChoiseIndex=4
            let dayName=DaysOfTheWeek.Wednesday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 5:
            self.latestDayChoiseIndex=5
            let dayName=DaysOfTheWeek.Thursday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 6:
            self.latestDayChoiseIndex=6
            let dayName=DaysOfTheWeek.Friday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 7:
            self.latestDayChoiseIndex=7
            let dayName=DaysOfTheWeek.Saturday.rawValue.lowercased()
               var tasks=taskModel.retrieveAllTasks()
                   
                   tasks.sort {
                                  ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                      ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                              }
              let endOfWeek = CustomDate(context: managedContext)
                  endOfWeek.year=Date().endOfWeek.year
                  endOfWeek.month=Date().endOfWeek.month
                  endOfWeek.day=Date().endOfWeek.day
               
              var matchingTasks = [Task]()
              for task in tasks{
                  if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                  {
                      matchingTasks.append(task)
                  }
              }
              
              allTasks=matchingTasks
        default:
             retrieveAllTasks()
        }
        
        
        
        
    }
    
    func GetTasksByDatesSeparation() -> [TasksAndDates]
    {
        var tasks=taskModel.retrieveAllTasks()
             
             tasks.sort {
                        ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                            ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                    }
        var separatedTasks=[TasksAndDates]()
       
        var tempTaskArray=[Task]()
        
        var latestIndexCatalyst=0
        if(!tasks.isEmpty)
        {
            for index in 0...tasks.count-1{
                
              
                
                if(index != 0 && tasks[index-1].date != tasks[index].date )
                {
                    if(tasks[index].date.day==25)
                    {
                        
                        print("ok separated")
                    }
                    for secIndex in latestIndexCatalyst...index-1
                    {
                        tempTaskArray.append(tasks[secIndex])
                        
                    }
                    latestIndexCatalyst=index
                    separatedTasks.append(TasksAndDates(date:tasks[index-1].date,tasks:tempTaskArray))
                    tempTaskArray=[]
                }
                
                if(index == tasks.count-1)
                {
                    for secIndex in latestIndexCatalyst...index
                    {
                           tempTaskArray.append(tasks[secIndex])
                           
                    }
                   latestIndexCatalyst=index
                   separatedTasks.append(TasksAndDates(date:tasks[index].date,tasks:tempTaskArray))
                   tempTaskArray=[]
                      
                }
                
            }
        }
        return separatedTasks
        
        
    }
    
    func getTaskColor(color:String) -> Color
    {
        
        return taskModel.getTaskColor(color:color)
    }
    
    func retrieveAllDayTasks(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllDayTasks(hour:hour)
    }
    
    
    func retrieveAllTasksByHourOrginal(hour:Int) ->[TasksPerHourPerDay]
     {

         return taskModel.retrieveAllTasksByHourOrginal(hour: hour)
     }
    
    func retrieveAllTasksByHour(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllTasksByHour(hour:hour)
    }
    
    func retrieveAllTasksByHour(hour:Int,sequanceNum:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllTasksByHour(hour:hour,sequanceNum:sequanceNum)
    }
    
    func retrieveAllTasksByHour()
      {
            self.allTasksPerHourInWeek=taskModel.retrieveAllTasksByHour()
      }
    
     func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime :Int32, newDueDate : Date, newNotes : String ){
        
        taskModel.updateData(orginalTaskName: orginalTaskName, newTaskName: newTaskName, newImportance: newImportance, newAsstimatedWorkTime: newAsstimatedWorkTime, newDueDate: newDueDate, newNotes: newNotes)
        
    }
    
    func UpdateData(id:UUID,newTaskName : String, newNotes : String,color:Color ){
        

        
        taskModel.UpdateData(id: id, newTaskName: newTaskName, newNotes: newNotes, color: color.description)
          
      }
    

    
    
    func deleteTask(taskId : UUID){
    
        taskModel.deleteTask(taskId : taskId)
        self.UpdateAllTasks()
         self.GetDayTasksByIndex(index: latestDayChoiseIndex)//In order to update the published task array after deletion
    }

    func getTask(taskId:UUID)
    {
        
        viewModelTask=taskModel.retrieveTask(taskID: taskId)
        
        self.taskName=viewModelTask!.taskName
        self.importance=viewModelTask!.importance!
        //self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        print(viewModelTask!.asstimatedWorkTime)
        self.dueDate=viewModelTask!.dueDate
        self.notes=viewModelTask!.notes!
        self.date=viewModelTask!.date
        //self.startTime=viewModelTask.startTime!
        //self.endTime=viewModelTask.endTime!
        self.id=viewModelTask!.id
        self.color=taskModel.getTaskColor(color: viewModelTask!.color!)
        
        SetViewHourStandard(startTime: viewModelTask!.startTime!, endTime: viewModelTask!.endTime!, asstimatedWorkTime: viewModelTask!.asstimatedWorkTime)
    }
    
    
 
}

