//
//  SubscriptionDelegate.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/12/24.
//

//import Foundation
//import CloudKit
//
//// MARK: - SubscriptionServiceDelegate Protocol
//
///// Protocol to handle subscription failures
//protocol SubscriptionServiceDelegate: AnyObject {
//    func subscriptionDidFailWithError(_ error: Error)
//}
//
//// MARK: - SubscriptionService Class
//
///// Manages CloudKit subscriptions for various record types
//class SubscriptionService {
//    /// Weak reference to the delegate to avoid retain cycles
//    weak var delegate: SubscriptionServiceDelegate?
//    
//    // MARK: - SubscriptionKey Enum
//    
//    /// Enum to define keys for different types of subscriptions
//    enum SubscriptionKey: String, CaseIterable {
//        case classroomSettingsToleranceKey
//        case studentPresenceChange
//        case questionsChange
//        case warnings
//    }
//    
//    // MARK: - Initialization
//    
//    /// Initializes the SubscriptionService with an optional delegate
//    /// - Parameter delegate: The delegate to handle subscription failures
//    init(delegate: SubscriptionServiceDelegate? = nil) {
//        self.delegate = delegate
//    }
//    
//    // MARK: - Private Methods
//    
//    /// Creates and saves a CloudKit subscription for silent notifications
//    /// - Parameters:
//    ///   - record: The CloudKit record type to subscribe to
//    ///   - options: The subscription options
//    ///   - desiredKeys: The keys to include in the notification payload
//    ///   - predicate: The predicate to filter the subscription
//    ///   - category: The notification category (iOS only)
//    ///   - subscriptionKey: The key to identify this subscription
//    private func subscribeForSilentNotification<T: CloudKitModel>(
//        ofRecord record: T.Type,
//        options: CKQuerySubscription.Options,
//        desiredKeys: [String],
//        predicate: NSPredicate = NSPredicate(value: true),
//        category: String? = nil,
//        subscriptionKey: SubscriptionKey
//    ) {
//        let className = String(describing: T.self)
//        let subscription = CKQuerySubscription(recordType: className, predicate: predicate, options: options)
//        
//        let notificationInfo = CKSubscription.NotificationInfo()
//        notificationInfo.desiredKeys = desiredKeys
//        notificationInfo.shouldSendContentAvailable = true
//        
//        #if os(iOS)
//        notificationInfo.category = category
//        #endif
//        
//        subscription.notificationInfo = notificationInfo
//        
//        CKStack.default.sharedDB.save(subscription) { [weak self] (createdSubscription, error) in
//            guard let self = self else { return }
//            
//            if let error = error {
//                self.delegate?.subscriptionDidFailWithError(error)
//                print("Subscription error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let newSubscription = createdSubscription {
//                UserDefaults.standard.set(newSubscription.subscriptionID, forKey: subscriptionKey.rawValue)
//            }
//        }
//    }
//    
//    // MARK: - Public Subscription Methods
//    
//    /// Subscribes to changes in classroom settings
//    /// - Parameter classroom: The classroom to subscribe to
//    func subscribeToClassroomSettingsChange(classroom: Classroom) {
//        guard let settings = classroom.settings else { return }
//        subscribeForSilentNotification(
//            ofRecord: ClassroomSettings.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["tolerance", "endHour", "startHour", "isCountingHour", "nfcTag"],
//            predicate: NSPredicate(format: "recordID == %@", settings.recordID),
//            category: APNSCategory.classroomSettingsCategory.rawValue,
//            subscriptionKey: .classroomSettingsToleranceKey
//        )
//    }
//    
//    /// Subscribes to changes in user presence for a specific classroom
//    /// - Parameter classroom: The classroom to subscribe to
//    func subscribeToUserChange(classroom: Classroom) {
//        let reference = CKRecord.Reference(recordID: classroom.id, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: User.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["isPresent", "emoji"],
//            predicate: NSPredicate(format: "classroom == %@", reference),
//            category: APNSCategory.tvOS.rawValue,
//            subscriptionKey: .studentPresenceChange
//        )
//    }
//    
//    /// Subscribes to new or updated questions in a classroom
//    /// - Parameter classroom: The classroom to subscribe to
//    func subscribeToQuestions(in classroom: Classroom) {
//        let reference = CKRecord.Reference(recordID: classroom.id, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: Question.self,
//            options: [.firesOnRecordCreation, .firesOnRecordUpdate],
//            desiredKeys: ["user", "order", "classroom", "isAnswered", "isCancelled"],
//            predicate: NSPredicate(format: "classroom == %@", reference),
//            category: APNSCategory.tvOS.rawValue,
//            subscriptionKey: .questionsChange
//        )
//    }
//    
//    /// Subscribes to warnings for a specific user
//    /// - Parameter user: The user to subscribe to warnings for
//    func subscribeToWarnings(for user: User) {
//        let numberOfWarningsUntilNotification = 3
//        let recordToMatch = CKRecord.Reference(record: user.record, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: User.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["name", "numberOfWarnings"],
//            predicate: NSPredicate(format: "advisor == %@ AND numberOfWarnings >= %i", recordToMatch, numberOfWarningsUntilNotification),
//            category: APNSCategory.attendanceWarning.rawValue,
//            subscriptionKey: .warnings
//        )
//    }
//    
//    // MARK: - Unsubscribe Methods
//    
//    /// Unsubscribes from all subscriptions
//    /// - Parameter completion: Closure to be called when all unsubscriptions are complete
//    func unsubscribeAll(completion: @escaping () -> Void) {
//        let group = DispatchGroup()
//        
//        for key in SubscriptionKey.allCases {
//            group.enter()
//            unsubscribeForKey(key) {
//                group.leave()
//            }
//        }
//        
//        group.notify(queue: .main) {
//            completion()
//        }
//    }
//    
//    /// Unsubscribes from a specific subscription
//    /// - Parameters:
//    ///   - key: The key of the subscription to unsubscribe from
//    ///   - completion: Closure to be called when unsubscription is complete
//    private func unsubscribeForKey(_ key: SubscriptionKey, completion: @escaping () -> Void) {
//        guard let subscriptionID = UserDefaults.standard.string(forKey: key.rawValue) else {
//            completion()
//            return
//        }
//        
//        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID) { (_, error) in
//            if let error = error {
//                print("Unsubscribe error for \(key): \(error.localizedDescription)")
//            }
//            UserDefaults.standard.removeObject(forKey: key.rawValue)
//            completion()
//        }
//    }
//}

/// This code will be used and or modified for a future date as it pertains to real-time updates between the application and the server. 
