//
//  TaskModel.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class TaskModel : UIViewController
{
    var coreManagment = Core()
    var allTasks = [Task]()
    
    
    func autoFillTesting()
    {
        let taskName = ["Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger"]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext


        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 7
        dateComponents.day = 25


        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        
        let asstimatedWorkTime=Hour(context: managedContext)
            asstimatedWorkTime.hour=5
            asstimatedWorkTime.minutes=15
        
        for name in taskName
        {
            
            asstimatedWorkTime.hour=Int.random(in: 1 ... 5)
            asstimatedWorkTime.minutes=Int.random(in: 0 ... 59)
            
            coreManagment.ScheduleTask(taskName: name, importance: "Very High", asstimatedWorkTime: asstimatedWorkTime, dueDate: someDateTime!, notes: "Hi")
            
            do {
                      try managedContext.save()
                          print("Saved Task !.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
        }
        

        
    }
    func createData(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        coreManagment.ScheduleTask(taskName: taskName, importance: importance, asstimatedWorkTime: asstimatedWorkTime, dueDate: dueDate, notes: notes)
            
            /*let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
            task.setValue(retrivedTask.taskName, forKeyPath: "taskName")
            task.setValue(retrivedTask.importance, forKeyPath: "importance")
            task.setValue(retrivedTask.asstimatedWorkTime, forKeyPath: "asstimatedWorkTime")
            task.setValue(retrivedTask.dueDate, forKeyPath: "dueDate")
            task.setValue(retrivedTask.notes, forKeyPath: "notes")
            task.setValue(retrivedTask.startTime, forKeyPath: "startTime")
            task.setValue(retrivedTask.date, forKeyPath: "date")
            task.setValue(retrivedTask.endTime, forKeyPath: "endTime")
            task.setValue(retrivedTask.completed, forKeyPath: "completed")
            task.setValue(retrivedTask.color, forKeyPath: "color")
            task.setValue(retrivedTask.active, forKeyPath: "active")
            task.setValue(UUID(), forKeyPath: "id")*/
        

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                print("Saved Task !.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveTask(taskID : UUID) -> Task {
                              
                  let emptyTask = Task ()
        
                  //As we know that container is set up in the AppDelegates so we need to refer that container.
                  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emptyTask }
                  
                  //We need to create a context from this container
                  let managedContext = appDelegate.persistentContainer.viewContext
                  
                  let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                 fetchRequest.predicate = NSPredicate(format: "id = %@", taskID as CVarArg)
                  do
                  {
                      let requiredTask = try managedContext.fetch(fetchRequest)
             
                          let retrievedObject = requiredTask[0] as! Task
                       
                    print("Name:",retrievedObject.taskName as! String)
                    
                      return retrievedObject
                  }
                    
                  catch
                  {
                      print(error)
                  }
        
            //Shouldn't get here theoretically
            return emptyTask
        }
    
    func retrieveTask(taskName : String) -> Task {
                                 
                     let emptyTask = Task ()
           
                     //As we know that container is set up in the AppDelegates so we need to refer that container.
                     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emptyTask }
                     
                     //We need to create a context from this container
                     let managedContext = appDelegate.persistentContainer.viewContext
                     
                     let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                    fetchRequest.predicate = NSPredicate(format: "taskName = %@", taskName as CVarArg)
                     do
                     {
                         let requiredTask = try managedContext.fetch(fetchRequest)
                
                             let retrievedObject = requiredTask[0] as! Task
                          
                       print("Name:",retrievedObject.taskName as! String)
                       
                         return retrievedObject
                     }
                       
                     catch
                     {
                         print(error)
                     }
           
               //Shouldn't get here theoretically
               return emptyTask
           }
    
    
    func retrieveAllTasks() -> [Task] {
           
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                allTasks=[]
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [Task] {
                 
                        allTasks.append(data)
                        print(data.taskName)
                
                    
                    /*print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String," Id:",data.value(forKey: "id") as! UUID )*/
               
                }
                print("Retrived all tasks !")
                
            } catch {
                
                print("Failed")
            }
        
        return allTasks
        }
    
    func retrieveAllTasksByHour(hour:Int) -> [TasksPerHourPerDay] {
           
            var allTasks=[TasksPerHourPerDay]()
            var coreManagment=Core()
        
            let startOfDay=7
            let endOfDay=24
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
            fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day >= %@ AND date.day <= %@", argumentArray: [Date().year,Date().month,19,25])
            
        let nextHour = Hour(context: managedContext)
            nextHour.hour=hour+1
            nextHour.minutes=0
        
        let beginningOfHour = Hour(context: managedContext)
        beginningOfHour.hour=hour
        beginningOfHour.minutes=0
        
            let weekSequence=coreManagment.createCalanderSequence(startDay: 19, startMonth: 7, startYear: 2020, endDay: 25, endMonth: 7, endYear: 2020)
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                
                var result = try managedContext.fetch(fetchRequest) as! [Task]
                
                result.sort {
                    ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour) <
                        ($1.date.year,$1.date.month,$1.date.day,$0.startTime!.hour)
                }
                
                  //  var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                
                var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                    for dayOfTheWeek in weekSequence
                    {
                        if(result.contains(where: { dayOfTheWeek.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)  && (($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour))}))
                        {
                            let data = result.all(where: { dayOfTheWeek.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) && (($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour)) })

                           tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                            
                            tasksPerHourPerDay.isEmptySlot=false
                            
                            
                            var heightFactor=CGFloat(1.6)
                            
                            if(data.count > 1)
                            {
                                heightFactor=1.9
                                
                                
                                for task in data{
                                                         
                                    tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: task.taskName))
              
                                }
                                                     
                            }
                            /*else{
                                heightFactor=1.6
                            }*/
                            else{
                                
                                if(data[0].startTime!.isBigger(newHour: beginningOfHour))
                                 {
                                     tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: ""))
                                 }
                                
                                tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName))
                                        //Multiple tasks per hour
                                
                                if(data[0].endTime! < nextHour)
                                 {
                                      tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: ""))
                                 }
                                
                                
                            }
                     
          
                          
                        }
                        else{//Case it's an empty hour for that day (index)
                            tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: true, tasks: [TaskPerHour]())
                            //tasksPerHourPerDay.isEmptySlot=true
                        }
                        
                        allTasks.append(tasksPerHourPerDay)//Tasks per hour
                       
                        tasksPerHourPerDay.tasks=[]
                    }
                    
                
                   
                        //allTasks.append(TasksByHour(data)
                        
                   // allTasks.append(tasksByHour)//All hours of the week followed each by all the appropriate tasks for each hour for the week
                    
                 /*   for data in allTasks
                    {
                        
                        print(data.hour)
                        for oneString in data.tasks
                        {
                            print(oneString)
                        }
                        print("-----")
                    }*/
                    /*print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String," Id:",data.value(forKey: "id") as! UUID )*/
               
                
                print("Retrived all tasks !")
                
            } catch {
                
                print("Failed")
            }
        
        return allTasks
        }
    
    func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime : Int32, newDueDate : Date, newNotes : String ){
     
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
         fetchRequest.predicate = NSPredicate(format: "taskName = %@", orginalTaskName)
         do
         {
             let requiredTask = try managedContext.fetch(fetchRequest)
    
                 let objectUpdate = requiredTask[0] as! NSManagedObject
                 objectUpdate.setValue(newTaskName, forKey: "taskName")
                 //objectUpdate.setValue("newImportance", forKey: "importance")
                 //objectUpdate.setValue("newAsstimatedWorkTime", forKey: "asstimatedWorkTime")
                 //objectUpdate.setValue("newDueDate", forKey: "dueDate")
                 objectUpdate.setValue(newNotes, forKey: "notes")
   
                 do{
                     try managedContext.save()
                    print("Updated !.")
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
    
    func deleteTask(taskName : String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "taskName = %@", taskName)
       
        do
        {
            let requiredTask = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = requiredTask[0] as! NSManagedObject
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
    
    /*
    func AddTask(mangedObjectContext : NSMangedObjectContext,taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        print(dueDate , " I am in Model task")
        let newTask = Task(context: mangedObjectContext)
                                 newTask.taskName = taskName
                                 newTask.importance = importance
                                 newTask.asstimatedWorkTime = asstimatedWorkTime
                                 newTask.dueDate = dueDate
                                 newTask.notes=notes
                                 newTask.id = UUID()
                               
        print(newTask)
                                 do {
                                  try mangedObjectContext.save()
                                  print("Task saved.")
                                 } catch {
                                  print(error.localizedDescription," Catched in Task model")
                                  }
        
        
    }
    */
    
    
    
    
}

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}

