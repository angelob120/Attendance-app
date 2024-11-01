//
//  UserPhotoLoader.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/7/24.
//

//import Foundation
//import UIKit
//import CloudKit
//
//class PhotoLoader {
//    
//    // Singleton instance for global access
//    public static let shared = PhotoLoader()
//    
//    // In-memory cache for storing user photos
//    private let cache = NSCache<CKRecord.ID, UIImage>()
//    
//    // Saves a photo to the cache for a specific user
//    func save(_ photo: UIImage, for userID: CKRecord.ID) {
//        cache.setObject(photo, forKey: userID)
//    }
//    
//    // Retrieves a photo for a user from cache or file
//    func photo(for userID: CKRecord.ID) -> UIImage? {
//        // Check if the photo is in the cache
//        if let cachedPhoto = cache.object(forKey: userID) {
//            return cachedPhoto
//        }
//        // If not in cache, try to load from CloudKit
//        // Note: This would typically involve a CloudKit fetch operation
//        // For demonstration, we'll return nil here
//        return nil
//    }
//    
//    // Asynchronously loads a photo for a given user ID
//    func loadPhoto(for userID: CKRecord.ID, caching: Bool = true, completion: @escaping (UIImage?) -> Void) {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            // Check cache first if caching is enabled
//            if caching, let cachedPhoto = self?.cache.object(forKey: userID) {
//                DispatchQueue.main.async {
//                    completion(cachedPhoto)
//                }
//                return
//            }
//            
//            // If not in cache, fetch from CloudKit
//            let recordID = CKRecord.ID(recordName: userID.recordName)
//            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
//                guard let record = record,
//                      let asset = record["photo"] as? CKAsset,
//                      let fileURL = asset.fileURL,
//                      let image = UIImage(contentsOfFile: fileURL.path) else {
//                    DispatchQueue.main.async {
//                        completion(nil)
//                    }
//                    return
//                }
//                
//                // Cache the fetched image if caching is enabled
//                if caching {
//                    self?.cache.setObject(image, forKey: userID)
//                }
//                
//                DispatchQueue.main.async {
//                    completion(image)
//                }
//            }
//        }
//    }
//    
//    // Removes a user's photo from the cache
//    func clear(for userID: CKRecord.ID) {
//        cache.removeObject(forKey: userID)
//    }
//
//    // MARK: - Cache Management
//
//    // Time interval for cache expiration (1 hour)
//    private let cacheExpirationInterval: TimeInterval = 3600
//    
//    // Timestamp of the last cache clear operation
//    private var lastCacheClearTime: Date = Date()
//    
//    // Maximum number of items to keep in the cache
//    private let maxCacheSize: Int = 100
//    
//    /// Manages the cache by clearing expired items and limiting cache size
//    private func manageCacheIfNeeded() {
//        let now = Date()
//        
//        // Clear entire cache if the expiration interval has passed
//        if now.timeIntervalSince(lastCacheClearTime) > cacheExpirationInterval {
//            cache.removeAllObjects()
//            lastCacheClearTime = now
//        }
//        
//        // Limit cache size if it exceeds the maximum
//        if cache.countLimit > maxCacheSize {
//            // This is a simplistic approach. In a real app, you might want to remove
//            // least recently used items or use a more sophisticated strategy.
//            cache.removeAllObjects()
//        }
//    }
//    
//    /// Clears the entire cache manually
//    func clearEntireCache() {
//        cache.removeAllObjects()
//        lastCacheClearTime = Date()
//    }
//    
//    /// Sets the maximum cache size
//    /// - Parameter size: The maximum number of items to keep in the cache
//    func setMaxCacheSize(_ size: Int) {
//        cache.countLimit = size
//    }
//    
//    /// Modifies the existing loadPhoto method to include cache management
//    func loadPhotoWithCacheManagement(for userID: CKRecord.ID, caching: Bool = true, completion: @escaping (UIImage?) -> Void) {
//        manageCacheIfNeeded() // Perform cache management before loading
//        loadPhoto(for: userID, caching: caching, completion: completion)
//    }
//}
/// This code will be used for future purposes upon determination of handling user photos within the application.
