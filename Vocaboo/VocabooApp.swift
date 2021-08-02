//
//  VocabooApp.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import SwiftUI

@main
struct VocabooApp: App {
    // our custom app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TrendingVocabulariesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
