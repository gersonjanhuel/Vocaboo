//
//  TrendingVocabViewModel.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import Foundation
import CloudKit

class TrendingVocabViewModel: ObservableObject {
    // our array of trending vocabularies
    @Published var trendingVocabs: [TrendingVocab] = []
    
    // our CloudKit Public database
    let database = CKContainer(identifier: "iCloud.gersonjanhuel.VocabooTest").publicCloudDatabase
    
    // query our data from CloudKit
    func fetchTrendingVocabs() {
        // CloudKit query from our record type
        let query = CKQuery(recordType: "TrendingVocab", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: .default) { records, error in
            guard let records = records, error == nil else { return }
            
            // cast all records become TrendingVocab model and add it to our array
            DispatchQueue.main.async { [self] in
                self.trendingVocabs = records.compactMap { TrendingVocab(id: UUID(), recordID: $0.recordID, word: $0["word"] as! String) }
            }
        }
    }
}
