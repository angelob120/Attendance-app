//
//  Untitled.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/22/24.
//

import AppIntents
import Foundation



@AssistantIntent(schema: .photos.openAsset)
struct OpenAssetIntent: OpenIntent {
    static var title: LocalizedStringResource = "Open Photo"
    static var description: LocalizedStringResource = "Open a selected photo"
    
    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$target)")
    }
    
    @Parameter(title: "Photo")
    
    
    var target: PhotosAssetEntity
    
// Call into the applications existing logic
// to open and display the photo
    func perform() async throws -> some IntentResult {
        
        print("Opening photo: \(target.identifier)")
      return .result()
    }
}
