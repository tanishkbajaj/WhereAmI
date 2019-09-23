//
//  WorkingWithCoreDataBase.swift
//  WhereAmI
//
//  Created by IMCS on 9/21/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDatabase {
    
    static func saveLocation (_ location : Location) {
    
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Location",
                                       in: managedContext)!
        
        let pin = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
        
        // 3
        pin.setValue(location.address, forKeyPath: "address")
        pin.setValue(location.latitude, forKeyPath: "latitude")
        pin.setValue(location.longitude, forKeyPath: "longitude")
        pin.setValue(location.date, forKey: "date")
        // 4
        do {
            try managedContext.save()
            print("SSS")
            print(location.address, location.latitude, location.longitude)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    static func deleteLocation (_ location : Location) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        print(location.address)
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Location")
        
        fetchRequest.predicate = NSPredicate(format: "(date = %@)", location.date as CVarArg)
        
        do
        {
            let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            for entity in fetchedResults! {
                
                managedContext.delete(entity)
            }
        }
        catch _ {
            print("Could not delete")
            
        }
        
    }
    
    static func updateLocation (_ location : Location) {
        
      
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Location")
        let predicate = NSPredicate(format: "(date = %@)", location.date as CVarArg)
        fetchRequest.predicate = predicate
        do
        {
            let object = try context.fetch(fetchRequest)
            if object.count == 1
            {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(location.address, forKey: "address")
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    
    static func fetchLocations () -> [Location] {
        
        var fetchLocations = [Location]()
      
        //1
        if let appDelegate =
            UIApplication.shared.delegate as? AppDelegate {
          
        
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Location")
        
        
        
        do {
            if  let pin : [NSManagedObject] = try managedContext.fetch(fetchRequest)
            {
                print("FFF")
                print(pin[0].value(forKeyPath: "address")!)
                print(pin[0].value(forKeyPath: "latitude")!)
                print(pin[0].value(forKeyPath: "longitude")!)
                print(pin[0].value(forKeyPath: "date")!)
                
                for index in 0..<pin.count {
                    var fetchLocation = Location()
                    fetchLocation.address = (pin[index].value(forKeyPath: "address")! as? String)!
                    fetchLocation.latitude = pin[index].value(forKeyPath: "latitude")! as! Double
                    fetchLocation.longitude = pin[index].value(forKeyPath: "longitude")! as! Double
                    fetchLocation.date = pin[index].value(forKeyPath: "date")! as! Date
                    fetchLocations.append(fetchLocation)
                }
            }
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        }
        return fetchLocations
    }
    
    static func fetchLastLocation() -> Location {
        return fetchLocations().last!
    }
    
}
