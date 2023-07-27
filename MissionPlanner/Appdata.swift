//
//  Appdata.swift
//  MissionPlanner
//
//  Created by apple on 21/04/2023.
//


//import SwiftUI
import Foundation

struct Tasklist: Codable,Identifiable{
    struct sub: Codable,Identifiable{
        var id:Double
        var content: String
        var point: Int
        var condition:Bool
        var index:Int
    }
    var task: String
    var id:Double
    var subtask:[sub]
}

struct Appdata: Codable{
    var list:[Tasklist]

}

func loadJsonData()->[Tasklist]{
    let filename: String = "task.json"
    guard let url=Bundle.main.url(forResource: filename, withExtension: nil)else{
        fatalError("can not find \(filename) in main bundle")
    }
    guard let data = try? Data(contentsOf:url)else{
        fatalError("can not load \(url)")
    }
    guard let appData = try? JSONDecoder().decode(Appdata.self,from:data)else{
        fatalError("can not parse post list json data")
    }
    

    return appData.list
    
}

