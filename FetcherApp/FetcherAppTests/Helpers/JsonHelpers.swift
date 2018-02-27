//
//  JsonHelpers.swift
//
//  Created by nicole ruduss.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

public class JsonHelpers: NSObject {
    
    public static func getJsonFile<T>(_ file: String) -> T? {
        
        let bundle = Bundle(for: object_getClass(self)!)
        
        if let fileURL = bundle.path(forResource: file, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: fileURL)) {
                return data as? T
            }
        }
        return nil
    }
    
    // Convert from NSData to json object
    static func nsdataToJSON(_ data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    
}
