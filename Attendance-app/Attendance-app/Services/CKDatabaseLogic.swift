//
//  CKDatabaseLogic.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/25/24.
//

import Foundation
import CloudKit

// An Custom error enum for CKDatabaseLogic operations
enum CKDatabaseLogicError: Error {
    case operationFailed(String)
}

// Protocol defining the interface for CloudKit database operations
protocol CKDatabaseLogic {
    func deleteRecord(withID recordID: CKRecord.ID) async throws -> CKRecord.ID
    func record(for recordID: CKRecord.ID) async throws -> CKRecord
    func save(_ record: CKRecord) async throws -> CKRecord
    func perform(_ query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?) async throws -> [CKRecord]
    func modifySubscriptions(_ subscriptionsByID: [CKSubscription.ID: CKSubscription]?) async throws -> ([CKSubscription.ID: CKSubscription]?, [CKSubscription.ID: Error]?)
}

// Extension to make CKDatabase conform to CKDatabaseLogic
extension CKDatabase: CKDatabaseLogic {
    func modifySubscriptions(_ subscriptionsByID: [CKSubscription.ID : CKSubscription]?) async throws -> ([CKSubscription.ID : CKSubscription]?, [CKSubscription.ID : any Error]?) {
        // Placeholder
            return (nil, nil)
    }
    
    // Async method to delete a record
    func deleteRecord(withID recordID: CKRecord.ID) async throws -> CKRecord.ID {
        try await withCheckedThrowingContinuation { continuation in
            self.delete(withRecordID: recordID) { deletedRecordID, error in
                if let error = error {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed(error.localizedDescription))
                } else if let deletedRecordID = deletedRecordID {
                    continuation.resume(returning: deletedRecordID)
                } else {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed("Unknown error"))
                }
            } // End of delete closure
        } // End of withCheckedThrowingContinuation
    } // End of deleteRecord method
    
    // Async method to fetch a record
    func record(for recordID: CKRecord.ID) async throws -> CKRecord {
        try await withCheckedThrowingContinuation { continuation in
            self.fetch(withRecordID: recordID) { record, error in
                if let error = error {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed(error.localizedDescription))
                } else if let record = record {
                    continuation.resume(returning: record)
                } else {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed("Record not found"))
                }
            } // End of fetch closure
        } // End of withCheckedThrowingContinuation
    } // End of record method
    
    // Async method to save a record
    func save(_ record: CKRecord) async throws -> CKRecord {
        try await withCheckedThrowingContinuation { continuation in
            self.save(record) { savedRecord, error in
                if let error = error {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed(error.localizedDescription))
                } else if let savedRecord = savedRecord {
                    continuation.resume(returning: savedRecord)
                } else {
                    continuation.resume(throwing: CKDatabaseLogicError.operationFailed("Failed to save record"))
                }
            } // End of save closure
        } // End of withCheckedThrowingContinuation
    } // End of save method
    
    // Async method to perform a query
    class YourClass {
        let database: CKDatabase
        
        init(database: CKDatabase = CKContainer.default().publicCloudDatabase) {
            self.database = database
        }
        
        func perform(_ query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?) async throws -> [CKRecord] {
            var allRecords: [CKRecord] = []
            var queryCursor: CKQueryOperation.Cursor? = nil  // Provide type annotation here
            
            repeat {
                let (matchResults, cursor) = try await database.records(
                    matching: query,
                    inZoneWith: zoneID,
                    desiredKeys: nil,
                    resultsLimit: CKQueryOperation.maximumResults
                )
                
                for case let .success(record) in matchResults.map({ $0.1 }) {
                    allRecords.append(record)
                }
                
                queryCursor = cursor
            } while queryCursor != nil
            
            return allRecords
        }
    }
}
