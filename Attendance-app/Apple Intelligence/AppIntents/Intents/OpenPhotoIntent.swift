//
//  Untitled.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/22/24.
//

//import AppIntents
//import Foundation
//
//
//
//@AssistantIntent(schema: .photos.openAsset)
//struct OpenAssetIntent: OpenIntent {
//    static var title: LocalizedStringResource = "Open Photo"
//    static var description: LocalizedStringResource = "Open a selected photo"
//    
//    static var parameterSummary: some ParameterSummary {
//        Summary("Open \(\.$target)")
//    }
//    
//    @Parameter(title: "Photo")
//    
//    
//    var target: PhotosAssetEntity
//    
//// Call into the applications existing logic
//// to open and display the photo
//    func perform() async throws -> some IntentResult {
//        
//        print("Opening photo: \(target.identifier)")
//      return .result()
//    }
//}





import Foundation
import AppIntents

@AssistantEntity(schema: .photos.asset)
struct PhotoAsset: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Photo Asset"
    }
    
    static var defaultQuery = PhotoAssetQuery()
    
    var id: UUID
    var title: String
    var creationDate: Date
    private var _mediaType: MediaType
    
    var mediaType: some AssistantSchemas.PhotosEnum {
        switch _mediaType {
        case .image:
            return .image
        case .video:
            return .video
        }
    }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(title)",
            subtitle: "Created on \(creationDate.formatted(date: .abbreviated, time: .shortened))",
            image: _mediaType == .image ? .init(systemName: "photo") : .init(systemName: "video")
        )
    }
    
    var idValue: UUID { id }
    
    init(id: UUID, title: String, creationDate: Date, mediaType: MediaType) {
        self.id = id
        self.title = title
        self.creationDate = creationDate
        self._mediaType = mediaType
    }
}

struct PhotoAssetQuery: EntityQuery {
    func entities(for identifiers: [UUID]) async throws -> [PhotoAsset] {
        // Implement this method to fetch PhotoAsset entities by their IDs
        []
    }
    
    func suggestedEntities() async throws -> [PhotoAsset] {
        // Implement this method to suggest PhotoAsset entities
        []
    }
}

extension PhotoAsset: Identifiable {}

@AssistantEnum(schema: .photos.mediaType)
enum MediaType: String, AppEnum {
    case image
    case video
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Media Type"
    }
    
    static var caseDisplayRepresentations: [MediaType : DisplayRepresentation] {
        [
            .image: DisplayRepresentation(title: "Image"),
            .video: DisplayRepresentation(title: "Video")
        ]
    }
}
