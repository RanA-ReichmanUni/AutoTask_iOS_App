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

    var allTasks = [Task]()
    
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
            task.setValue(UUID(), forKeyPath: "id")

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                print("Saved !.")
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

