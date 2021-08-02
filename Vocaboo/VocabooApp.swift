//
//  VocabooApp.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import SwiftUI

@main
struct VocabooApp: App {
    
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TrendingVocabulariesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
