//
//  CoreDataHelper.swift
//  EZV_Assignment
//
//  Created by Ferry Julian on 17/03/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    
    init() {
        container = NSPersistentContainer(name: "ProductAppModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("failed to load core data = ", error.localizedDescription)
            }
        }
    }
    
    func addProductToFavorite(product: DataProduct) {
        let favoriteProduct = ProductApp(context: container.viewContext)
        favoriteProduct.id = Int64(product.id ?? 0)
        favoriteProduct.title = product.title
        favoriteProduct.descriptionProduct = product.description
        favoriteProduct.thumbnail = product.thumbnail
        do {
            try container.viewContext.save()
            print("data saved \(favoriteProduct)")
        } catch {
            print("Failed to save data", error.localizedDescription)
        }
    }
    
    func getFavoriteProduct() {
        let request = NSFetchRequest<ProductApp>(entityName: "ProductApp")
        do {
            let result = try container.viewContext.fetch(request)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}
