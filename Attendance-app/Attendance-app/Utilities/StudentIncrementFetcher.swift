//
//  StudentIncrementFetcher.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/13/24.
//



//import CloudKit
//import Foundation
///// This code requires UIKIt for certain functions of this code.
//
//struct StudentsIncrementalFetcher {
//    // The classroom for which we're fetching students
//    let classroom: Classroom  /// Must find classroom in constant
//    
//    /// Fetches students in chunks, returning an AsyncStream of User arrays
//    /// - Parameter chunkSize: The number of students to fetch in each chunk (default: 100)
//    /// - Returns: An AsyncStream that yields arrays of User objects
//    func fetchStudents(chunkSize: Int = 100) -> AsyncStream<[User]> { ///Must find user in function
//        AsyncStream { continuation in
//            Task {
//                do {
//                    // Create the initial query
//                    let query = try self.createQuery()
//                    var cursor: CKQueryOperation.Cursor?
//                    
//                    repeat {
//                        // Fetch a chunk of students
//                        let (newCursor, students) = try await self.fetchChunk(query: query, cursor: cursor, limit: chunkSize)
//                        cursor = newCursor
//                        
//                        // Yield the fetched students if the array is not empty
//                        if !students.isEmpty {
//                            continuation.yield(students)
//                        }
//                    } while cursor != nil // Continue fetching while there are more results
//                    
//                    // Finish the stream when all students have been fetched
//                    continuation.finish()
//                } catch {
//                    // If an error occurs, finish the stream with the error
//                    continuation.finish(throwing: error)
//                }
//            }
//        }
//    }
//    
//    /// Creates a CKQuery to fetch active students for the given classroom
//    /// - Returns: A CKQuery object configured to fetch students
//    /// - Throws: An error if query creation fails
//    private func createQuery() throws -> CKQuery {
//        let classroomReference = CKRecord.Reference(record: classroom.record, action: .none)
//        let predicate = NSPredicate(format: "classroom == %@ AND role == %@ AND isActive == 1", classroomReference, Role.student.rawValue)
//        return CKQuery(recordType: User.className, predicate: predicate) /// Must create user for this record type.
//    }
//    
//    /// Fetches a single chunk of students from CloudKit
//    /// - Parameters:
//    ///   - query: The CKQuery to execute
//    ///   - cursor: An optional cursor for pagination
//    ///   - limit: The maximum number of records to fetch
//    /// - Returns: A tuple containing the next cursor (if any) and an array of fetched User objects
//    /// - Throws: An error if the fetch operation fails
//    private func fetchChunk(query: CKQuery, cursor: CKQueryOperation.Cursor?, limit: Int) async throws -> (CKQueryOperation.Cursor?, [User]) { /// Must define user for this record type.
//        try await withCheckedThrowingContinuation { continuation in
//            let operation = CKQueryOperation(query: query)
//            operation.resultsLimit = limit
//            operation.cursor = cursor
//            
//            var fetchedUsers = [User]()
//            
//            // Process each fetched record
//            operation.recordMatchedBlock = { _, result in
//                if case .success(let record) = result {
//                    fetchedUsers.append(User(withRecord: record))
//                }
//            }
//            
//            // Handle the query completion
//            operation.queryResultBlock = { result in
//                switch result {
//                case .success(let cursor):
//                    continuation.resume(returning: (cursor, fetchedUsers))
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//            
//            // Add the operation to the database
//            CKStack.default.publicDB.add(operation)
//        }
//    }
//}


/// Code will be modified for future date. 
