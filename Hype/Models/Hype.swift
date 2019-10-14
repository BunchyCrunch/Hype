//
//  Hype.swift
//  Hype
//
//  Created by Josh Sparks on 10/14/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation
import CloudKit

// MARK: - Hype Strings
struct HypeStrings {
    static let recordTypeKey = "Hype"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestampKey = "timestamp"
}

// MARK: - Class Declaration
class Hype {
    var body: String
    var timestamp: Date
    
    init(body: String, timestamp: Date = Date()) {
        self.body = body
        self.timestamp = timestamp
    }
}

// Cloud -> Hype

// MARK: - Convenience init extension
extension Hype {
    /**
        Convenience failable initializer that finds the key/value pairs in the passed in CKRecord and initializes a Hype from those.
     
            -Parameters:
            -ckRecord: CKRecord object should contian those key/value pairs of a Hype object stored in the cloud
     */
    convenience init? (ckRecord: CKRecord) {
        // Unwrapping the values for the keys stored in the CKRecord
        guard let body = ckRecord[HypeStrings.bodyKey] as? String,
            let timestamp = ckRecord[HypeStrings.timestampKey] as? Date
            else { return nil }
        
        self.init(body: body, timestamp: timestamp )
        
    }
}

// Hype -> Cloud
// MARK: CKRecord extension
extension CKRecord {
    /**
        Convenience initializer to create a CKRecord and set the key/value pairs based on our Hype model objects
     
        - Parameters:
        - hype: Hype object that we want to set CKRecord key/value pairs for
     */
    convenience init(hype: Hype) {
        // Initializes a CKRecord
        self.init(recordType: HypeStrings.recordTypeKey)
        // Set the key/value pairs for the CKRecord
        self.setValuesForKeys([
            HypeStrings.bodyKey : hype.body,
            HypeStrings.timestampKey : hype.timestamp
        ])
    }
}
