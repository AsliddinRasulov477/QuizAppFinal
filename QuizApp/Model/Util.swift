//
//  Util.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/10/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import Foundation
import UIKit

class Util{

    static let shared = Util()
    
    //MARK:- Getting Path to our database
    func getPath(dbName:String)->String {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(dbName)
        print(fileUrl.path)
        return fileUrl.path
    }
    
    //MARK:- If database Path is not exists creating database Path
    
    func copyDatabase(dbName:String){
        let dbPath = getPath(dbName: "tests.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath){
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(dbName)
            
            do{
                try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}

