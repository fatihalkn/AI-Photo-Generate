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
    
    func getData() -> [MyArtCollectionViewItem] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequset = NSFetchRequest<NSFetchRequestResult>(entityName: "Art")
        fetchRequset.returnsObjectsAsFaults = false
        
        do {
            var myArts: [MyArtCollectionViewItem] = []
            let results =  try context.fetch(fetchRequset)
            for result in results as! [NSManagedObject] {
                let image = result.value(forKey: "image") as? Data
                let id  = result.value(forKey: "id") as? UUID
                let prompt = result.value(forKey: "prompt") as? String
                let myArtCollectionViewItem = MyArtCollectionViewItem(imageData: image,
                                                                      imagePrompt: prompt,
                                                                      id: id)
                myArts.append(myArtCollectionViewItem)
                
            }
            
            return myArts
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
