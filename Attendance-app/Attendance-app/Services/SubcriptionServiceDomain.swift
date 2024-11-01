//
//  SubcriptionServiceDomain.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/25/24.
//

//import Foundation
//import CloudKit
//
//// Protocol for handling subscription-related events
//protocol SubscriptionServiceDelegate: AnyObject {
//    func subscriptionDidFailWithError(_ error: Error)
//    func subscriptionDidReceiveUpdate(for recordType: String, recordID: CKRecord.ID)
//}
//
//// Class to manage CloudKit subscriptions
//class SubscriptionService {
//    // Weak reference to the delegate to avoid retain cycles
//    weak var delegate: SubscriptionServiceDelegate?
//    // The database to use for subscriptions
//    private let database: CKDatabase
//    
//    // Enum to represent different types of subscriptions
//    enum SubscriptionKey: String {
//        case classroomSettings
//        case studentPresence
//        case questions
//        case warnings
//    }
//    
//    // Initializer with optional delegate and database
//    init(delegate: SubscriptionServiceDelegate? = nil, database: CKDatabase = CKContainer.default().sharedCloudDatabase) {
//        self.delegate = delegate
//        self.database = database
//    } // End of init
//
//    // Private method to create and save a subscription
//    private func subscribeForSilentNotification<T: CloudKitModel>(
//        ofRecord record: T.Type,
//        options: CKQuerySubscription.Options,
//        desiredKeys: [String],
//        predicate: NSPredicate = NSPredicate(value: true),
//        subscriptionKey: SubscriptionKey
//    ) {
//        let className = String(describing: T.self)
//        let subscription = CKQuerySubscription(recordType: className, predicate: predicate, options: options)
//        
//        let notificationInfo = CKSubscription.NotificationInfo()
//        notificationInfo.desiredKeys = desiredKeys
//        notificationInfo.shouldSendContentAvailable = true
//        subscription.notificationInfo = notificationInfo
//        
//        database.save(subscription) { [weak self] (savedSubscription, error) in
//            if let error = error {
//                self?.delegate?.subscriptionDidFailWithError(error)
//            } else if let newSubscription = savedSubscription {
//                UserDefaults.standard.set(newSubscription.subscriptionID, forKey: subscriptionKey.rawValue)
//            }
//        } // End of database.save closure
//    } // End of subscribeForSilentNotification method
//
//    // Method to subscribe to classroom settings changes
//    func subscribeToClassroomSettingsChange(classroom: Classroom) {
//        guard let settings = classroom.settings else { return }
//        subscribeForSilentNotification(
//            ofRecord: ClassroomSettings.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["tolerance", "endHour", "startHour", "isCountingHour", "nfcTag"],
//            predicate: NSPredicate(format: "recordID == %@", settings.recordID),
//            subscriptionKey: .classroomSettings
//        )
//    } // End of subscribeToClassroomSettingsChange method
//
//    // Method to subscribe to user changes in a classroom
//    func subscribeToUserChange(classroom: Classroom) {
//        let reference = CKRecord.Reference(recordID: classroom.id, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: User.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["isPresent", "emoji"],
//            predicate: NSPredicate(format: "classroom == %@", reference),
//            subscriptionKey: .studentPresence
//        )
//    } // End of subscribeToUserChange method
//
//    // Method to subscribe to questions in a classroom
//    func subscribeToQuestions(in classroom: Classroom) {
//        let reference = CKRecord.Reference(recordID: classroom.id, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: Question.self,
//            options: [.firesOnRecordCreation, .firesOnRecordUpdate],
//            desiredKeys: ["user", "order", "classroom", "isAnswered", "isCancelled"],
//            predicate: NSPredicate(format: "classroom == %@", reference),
//            subscriptionKey: .questions
//        )
//    } // End of subscribeToQuestions method
//
//    // Method to subscribe to warnings for a user
//    func subscribeToWarnings(for user: User) {
//        let numberOfWarningsUntilNotification = 3
//        let recordToMatch = CKRecord.Reference(record: user.record, action: .none)
//        subscribeForSilentNotification(
//            ofRecord: User.self,
//            options: [.firesOnRecordUpdate],
//            desiredKeys: ["name", "numberOfWarnings"],
//            predicate: NSPredicate(format: "advisor == %@ AND numberOfWarnings >= %i", recordToMatch, numberOfWarningsUntilNotification),
//            subscriptionKey: .warnings
//        )
//    } // End of subscribeToWarnings method
//
//    // Method to unsubscribe from a specific subscription
//    func unsubscribeForKey(_ key: SubscriptionKey, completion: (() -> Void)? = nil) {
//        guard let subscriptionID = UserDefaults.standard.string(forKey: key.rawValue) else {
//            completion?()
//            return
//        }
//        
//        database.delete(withSubscriptionID: subscriptionID) { [weak self] (_, error) in
//            if let error = error {
//                self?.delegate?.subscriptionDidFailWithError(error)
//            } else {
//                UserDefaults.standard.removeObject(forKey: key.rawValue)
//            }
//            completion?()
//        } // End of database.delete closure
//    } // End of unsubscribeForKey method
//
//    // Method to handle incoming notifications
//    func handleNotification(_ notification: CKNotification) {
//        guard let queryNotification = notification as? CKQueryNotification,
//              let recordID = queryNotification.recordID else {
//            return
//        }
//        
//        delegate?.subscriptionDidReceiveUpdate(for: queryNotification.recordType, recordID: recordID)
//    } // End of handleNotification method
//} // End of SubscriptionService class


/// Hold code for future reference as this code will be important for handling data check - in, check out as well as live updates
