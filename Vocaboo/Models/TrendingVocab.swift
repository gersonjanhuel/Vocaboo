//
//  TrendingVocab.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import Foundation
import CloudKit

// our model follow CloudKit record data structure
struct TrendingVocab: Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    
    // our custom fields
    var word: String = ""
}
