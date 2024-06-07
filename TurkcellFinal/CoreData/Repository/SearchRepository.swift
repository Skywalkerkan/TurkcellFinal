//
//  SearchRepository.swift
//  TurkcellFinal
//
//  Created by Erkan on 6.06.2024.
//

import CoreData
import UIKit


protocol SearchRepositoryProtocol {
    
    func saveSearch(search: Search)
    func fetchSearchedWords() -> [Search]?
}

final class SearchRepository: SearchRepositoryProtocol {
    
    
    func saveSearch(search: Search) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newSearch = NSEntityDescription.insertNewObject(forEntityName: "Searchs", into: context)
        newSearch.setValue(search.searchString, forKey: "search")

        
        do {
            try context.save()
        } catch {
            print("Save Error")
        }
    }
    
    func fetchSearchedWords() -> [Search]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Searchs")
        
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                var searchs: [Search]!
                
                for result in results as! [NSManagedObject] {
                    
                    if searchs == nil {
                        searchs = [Search]()
                    }
                    
                    let searchString = result.value(forKey: "search") as? String ?? "Okey"
                    let search = Search(searchString: searchString)
                    searchs.append(search)
                }
                if searchs != nil {
                    searchs = searchs.reversed()
                }
                
                return searchs
            } else {
                return [Search]()
            }
        }
        catch {
            print("error")
        }
        return nil
    }
}
