//
//  UserCloudKit.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/8/24.
//


//import UIKit
//import CloudKit
//
//final class UserCloudKit {
//    static let shared = UserCloudKit()
//    
//    // Cache the current user for faster access
//    var cachedUser: User?
//    
//    // Removed advisors property as it can be fetched when needed
//    
//    // Unique device identifier
//    var vendorID: String {
//        return UIDevice.current.identifierForVendor!.uuidString
//    }
//    
//    private init() {}
//    
//    // MARK: - User Creation
//    
//    func createUser(with name: String, _ email: String, _ phone: String, _ photoData: Data, on classroom: Classroom, completionHandler: @escaping (User?, Error?) -> Void) {
//        // ... (keep existing implementation)
//    }
//    
//    // MARK: - User Fetching
//    
//    func fetchCloudKitUser(completionHandler: @escaping (User?, Error?) -> Void) {
//        // ... (keep existing implementation)
//    }
//    
//    func cloudKitUser() async throws -> User? {
//        // ... (keep existing implementation)
//    }
//    
//    // MARK: - Advisor Management
//    
//    func setAdvisor(_ advisor: User?, for student: User, completionHandler: @escaping (Bool) -> Void) {
//        // ... (keep existing implementation)
//    }
//    
//    // MARK: - Student and Teacher Queries
//    
//    func students(for classroom: Classroom, completionHandler: @escaping ([User], Error?) -> Void) {
//        // ... (keep existing implementation)
//    }
//    
//    func fetchAvailableAdvisors(for student: User, completion: @escaping ([User]?) -> Void) {
//        // Remove caching of advisors and always fetch from CloudKit
//        let predicate = NSPredicate(format: "role == %@ AND recordID != %@", Role.teacher.rawValue, student.advisorId ?? "")
//        User.find(predicate) { (advisors, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            completion(advisors)
//        }
//    }
//    
//    func lookUpTeachers(completionHandler: @escaping ([User], Error?) -> Void) {
//        // ... (keep existing implementation)
//    }
//    
//    // MARK: - Image Fetching
//    
//    @discardableResult
//    func findImageForRecord(withKeys keys: [String], record: CKRecord.ID, completion:  @escaping (User?, Error?) -> Void) -> CKOperation {
//        // ... (keep existing implementation)
//    }
//    
//    // MARK: - Emoji Update
//    
//    func updateEmoji(to emojiCode: String) {
//        // ... (keep existing implementation)
//    }
//}
