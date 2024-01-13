//
//  db.swift
//  puzzle word
//
//  Created by Daniel on 2023/12/31.
//

import Foundation
import SQLite


func generateRandomArray(count: Int) -> [Int] {
    var randomArray: [Int] = []

    for _ in 1...count {
        let randomInt = Int(arc4random_uniform(100))
        randomArray.append(randomInt)
    }

    return randomArray
}

class Db {
    let wordListLength = 300;
    var wordItemList: [WordItem]?
    
    func generateWord() {
        do {
            
            if let dbPath = Bundle.main.path(forResource: "db", ofType: "sqlite3") {
                // Use the dbPath variable to open or copy the database as needed
                do {
                    let db = try Connection(dbPath)
                    
//                    let entries = Table("entries")
//                    let word = Expression<String>("word")
//                    let wordtype = Expression<String?>("wordtype")
//                    let definition = Expression<String>("definition")
                    
//                    let demo = entries.filter(id == rowid)
                    
                    let rows =  try db.prepare("SELECT word, wordtype, definition FROM entries where length(word) > 2 and length(word) < 20 order by  random() limit 300")
                    let randomIntegers = generateRandomArray(count: wordListLength)
                    wordItemList = []
                    for row in rows.enumerated() {
                        if randomIntegers.contains(row.offset) {
                            wordItemList?.append(WordItem(word: row.element[0] as! String, wordtype: row.element[1] as! String, definition: row.element[2] as! String))
                        }
                        
                    }
                    
                    
                } catch {
                    print (error)
                }
                
            } else {
                print("Database file not found in the bundle.")
            }
            
        }
    }
}
