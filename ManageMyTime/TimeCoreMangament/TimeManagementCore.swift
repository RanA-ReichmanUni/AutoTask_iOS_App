//
//  TimeManagementCore.swift
//  ManageMyTime
//
//  Created by רן א on 04/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TimeManagementCore{
    
    enum coreError: Error {
           case dayOfCurrentDayIsZero
           case badPassword
       }
    
    func retrieveAllSpaces() throws//We assume all appropriate days have been constructed beforehand
    {
         var id : UUID
         
         var startTime : Date
         var endTime : Date
         var day : dayOfTheWeek
         var dayOfToday = Date().day
        
        if (dayOfToday==0)
        {
            throw coreError.dayOfCurrentDayIsZero
        }
        
     
                    //As we know that container is set up in the AppDelegates so we need to refer that container.
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                      
                      //We need to create a context from this container
                    let managedContext = appDelegate.persistentContainer.viewContext
                      
             
            
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "OccupiedTimeSpace")
                   /* let predicate1 = NSPredicate(format: "month = %@",8)
                    let predicate2 = NSPredicate(format: "month <%@",15)
                    let predicate3 = NSPredicate(format: "year = %@",2020)
                    let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/
        
                    fetchRequest.predicate = NSPredicate(format: "month > %@ AND month < %@", argumentArray: [8, 11])
                      do
                      {
                          let results = try managedContext.fetch(fetchRequest)
                      
                        
                        for result in results as! [NSManagedObject] {
                                print("Name: ")
                                print(result.value(forKey: "assignedTaskName") as! String)
                                print("startTime: ")
                            print(result.value(forKey: "startTime")!)
                        }
                        
                      
                            // let retrievedObject = requiredTask[0] as! Task
                           
                       // print("Name:",retrievedObject.taskName as! String)
                        
                         
                      }
                        
                      catch
                      {
                          print(error)
                      }
            
            
            
            
            
        
        
        
            
    }
    
    
    func deleteSpace(assignedTaskName : String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OccupiedTimeSpace")
        fetchRequest.predicate = NSPredicate(format: "taskName = %@", assignedTaskName)
       
        do
        {
            let requiredSpace = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = requiredSpace[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
                print("Deleted !.")
               
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    
    
    func createData(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
    
            
            let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
            task.setValue(taskName, forKeyPath: "taskName")
            task.setValue(importance, forKeyPath: "importance")
            task.setValue(asstimatedWorkTime, forKeyPath: "asstimatedWorkTime")
            task.setValue(dueDate, forKeyPath: "dueDate")
            task.setValue(notes, forKeyPath: "notes")
            let id = UUID()
            task.setValue(id, forKeyPath: "id")

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                print("Saved !.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        
        let spaceEntity = NSEntityDescription.entity(forEntityName: "OccupiedTimeSpace", in: managedContext)!
              
              //final, we need to add some data to our newly created record for each keys using
              //here adding 5 data with loop
              
        let currentMinute=Calendar.current.component(.minute, from: Date())
  /*
                var dateComponents = DateComponents()
                  dateComponents.year = 2020
                  dateComponents.month = 7
                  dateComponents.day = 8
                  dateComponents.minute = currentMinute

                  // Create date from components
                  var userCalendar = Calendar.current // user calendar
                  let spaceDate = userCalendar.date(from: dateComponents)
        
                    
        dateComponents.year = 2020
                         dateComponents.month = 7
                         dateComponents.day = 8
                         dateComponents.hour = 9
                         dateComponents.minute = 0

                         // Create date from components
                          userCalendar = Calendar.current // user calendar
                         let startTime = userCalendar.date(from: dateComponents)
        
        
                    dateComponents.year = 2020
                                     dateComponents.month = 7
                                     dateComponents.day = 8
                                     dateComponents.hour = 10
                                     dateComponents.minute = 0

                                     // Create date from components
                                      userCalendar = Calendar.current // user calendar
                                     let endTime = userCalendar.date(from: dateComponents)
        
        */
        
        var startTime = 8
        var endTime = 9.5
        
                  let space = NSManagedObject(entity: spaceEntity, insertInto: managedContext)
                  space.setValue(taskName, forKeyPath: "assignedTaskName")
                  space.setValue(id, forKeyPath: "assignedTaskId")
                  space.setValue(false, forKeyPath: "restFreeSpace")
                  space.setValue(startTime, forKeyPath: "startTime")
                  space.setValue(endTime, forKeyPath: "endTime")
                  space.setValue("red", forKeyPath: "color")
                  space.setValue(UUID(), forKeyPath: "id")
                  space.setValue(7, forKeyPath: "day")
                  space.setValue(8, forKeyPath: "month")
                  space.setValue(2020, forKeyPath: "year")

              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved space !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
              
        
        
        
        
    }
        
        
        
        
        
        
}

extension Date {
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return dateFormatter.string(from: self)
    }
    var day: Int {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd"
         return Int(dateFormatter.string(from: self)) ?? 0
     }
    var year: String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy"
         return dateFormatter.string(from: self)
     }
    
    func dayOfWeek() -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           return dateFormatter.string(from: self).capitalized
          
       }//Get value by : "Date().dayOfWeek()!"
    
}


    
    
    
    

