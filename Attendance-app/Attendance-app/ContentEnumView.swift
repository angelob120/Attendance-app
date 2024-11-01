//
//  ContentEnumView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/7/24.
//


import SwiftUI

struct ThemeSettingsView: View {
    @Binding var currentTheme: ColorTheme
    
    // Add this computed property
    private var theme: ColorTheme {
        currentTheme
    }
    
    var body: some View {
        List {
            Section(header: Text("Choose Theme")) {
                Picker("Theme", selection: $currentTheme) {
                    ForEach(ColorTheme.allCases, id: \.self) { theme in
                        Text(theme.rawValue.capitalized)
                            .tag(theme)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Preview")) {
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(theme.backgroundColor)
                            .frame(width: 100, height: 100)
                        Text("Background")
                            .foregroundColor(theme.textColor)
                    }
                    
                    Spacer()
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(theme.tabBarColor)
                            .frame(width: 100, height: 100)
                        Text("Tab Bar")
                            .foregroundColor(theme.textColor)
                    }
                }
            }
        }
        .navigationTitle("Theme Settings")
    }
}
