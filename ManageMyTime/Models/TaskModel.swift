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
    
    
    func retrieveData() {
           
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
              
                    print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String)
               
                }
                
            } catch {
                
                print("Failed")
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

