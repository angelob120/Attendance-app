//
//  EnumColorTheme.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/7/24.
//

import SwiftUI

import SwiftUI

public enum ColorTheme: String, CaseIterable {
    case light, dark, ocean, forest, sunset

    var backgroundColor: Color {
        switch self {
        case .light:
            return .white
        case .dark:
            return .gray
        case .ocean:
            return Color(red: 0.1, green: 0.5, blue: 0.9)
        case .forest:
            return Color(red: 0.2, green: 0.7, blue: 0.3)
        case .sunset:
            return Color(red: 0.9, green: 0.6, blue: 0.3)
        }
    }

    var tabBarColor: Color {
           switch self {
           case .light:
               return Color(red: 76/255, green: 175/255, blue: 80/255)
           case .dark:
               return Color(red: 56/255, green: 142/255, blue: 60/255)
           case .ocean:
               return .blue
           case .forest:
               return .green
           case .sunset:
               return .orange
           }
       }
    
    var textColor: Color {
        switch self {
        case .light, .sunset:
            return .black
        case .dark, .ocean, .forest:
            return .white
        }
    }
    
    
    
    var tabBarTextColor: Color {
               switch self {
               case .light:
                   return .black
               case .dark, .ocean, .forest:
                   return .white
               case .sunset:
                   return .black
               }
           }
    
    var selectedTabColor: Color {
            switch self {
            case .light:
                return Color(red: 56/255, green: 142/255, blue: 60/255)
            case .dark:
                return Color(red: 76/255, green: 175/255, blue: 80/255)
            case .ocean:
                return .blue.opacity(0.7)
            case .forest:
                return .green.opacity(0.7)
            case .sunset:
                return .orange.opacity(0.7)
            }
        }
 
    var selectedTabOpacity: Double {
          switch self {
          case .light, .dark:
              return 1.0 // Full opacity for light and dark themes
          case .ocean, .forest, .sunset:
              return 0.2 // 20% opacity for other themes
          }
      }
 
}
