//
//  CodeResponseSerialiser.swift
//  FetcherApp
//
//  Created by nicole ruduss on 21/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation

class CodeResponseSerialiser: SerialiserProtocol {
    
    func serialise(_ data: Data) throws -> AnyObject? {
        
        var response: [String: AnyObject]?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: AnyObject]
        } catch let error as NSError {
            throw FetcherAppError.serialisationError(error.localizedDescription)
        }
        
        do {
            if let response = response {
                let mappedResult = try self.mapResponse(inputtedResponse: response)
                return mappedResult as AnyObject
            }
        } catch let error {
            throw error
        }
        return nil
    }
    
    private func mapResponse(inputtedResponse: [String: AnyObject]) throws -> CodeResponse? {
        guard let path = inputtedResponse["path"] as? String,
            let responseCode = inputtedResponse["response_code"] as? String
            else {
                throw FetcherAppError.parsingError(nil)
        }
        guard let uwResponseCode = UUID(uuidString: responseCode) else {
            throw FetcherAppError.parsingError("invalid UUID")
        }
        return CodeResponse(path: path, responseCode: uwResponseCode)
    }
}
