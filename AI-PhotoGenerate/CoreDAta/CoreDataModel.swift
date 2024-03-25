//
//  CoreDataModel.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 25.03.2024.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel {
    
    static let shared = CoreDataModel()
    
    var imageArray = [Data]()
    var idArray = [UUID]()
    var promptArray = [String]()
    
    
    func deleteItem(withID id: UUID) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Art")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
                context.delete(result)
                try context.save()
            }
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    func getData() {
        self.imageArray.removeAll(keepingCapacity: true)
        self.idArray.removeAll(keepingCapacity: true)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequset = NSFetchRequest<NSFetchRequestResult>(entityName: "Art")
        fetchRequset.returnsObjectsAsFaults = false
        
        do {
           let results =  try context.fetch(fetchRequset)
            for result in results as! [NSManagedObject] {
                if let image = result.value(forKey: "image") as? Data {
                    self.imageArray.append(image)
                }
                
                if let id  = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                
                if let prompt = result.value(forKey: "prompt") as? String {
                    self.promptArray.append(prompt)
                }
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
    }
}
