//
//  PhotoAsset.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/22/24.
//
//import Foundation
//import AppIntents
//
//@AssistantEntity(schema: .photos.asset)
//struct PhotoAsset: AppEntity {
//    static var typeDisplayRepresentation: TypeDisplayRepresentation {
//        "Photo Asset"
//    }
//    
//    static var defaultQuery = PhotoAssetQuery()
//    
//    var id: UUID
//    var title: String
//    var creationDate: Date
//    
//    // Removed the mediaType property
//    
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(
//            title: "\(title)",
//            subtitle: "Created on \(creationDate.formatted(date: .abbreviated, time: .shortened))"
//            // Remove the image property that was using mediaType
//        )
//    }
//    
//    var idValue: UUID { id }
//}
//
//struct PhotoAssetQuery: EntityQuery {
//    func entities(for identifiers: [UUID]) async throws -> [PhotoAsset] {
//        // Implement this method to fetch PhotoAsset entities by their IDs
//        []
//    }
//    
//    func suggestedEntities() async throws -> [PhotoAsset] {
//        // Implement this method to suggest PhotoAsset entities
//        []
//    }
//}
//
//extension PhotoAsset: Identifiable {}
//



