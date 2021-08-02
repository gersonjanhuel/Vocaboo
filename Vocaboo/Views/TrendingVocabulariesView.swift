//
//  ContentView.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import SwiftUI

struct TrendingVocabulariesView: View {
    
    @ObservedObject var trendingVocabViewModel = TrendingVocabViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(trendingVocabViewModel.trendingVocabs) { vocab in
                    Text(vocab.word)
                }
            }
            .navigationTitle("Trending")
            .listStyle(InsetListStyle())
            .navigationBarItems(
                trailing:
                    NavigationLink("My Vocabularies", destination: MyVocabulariesView())
            )
            .onAppear {
                trendingVocabViewModel.fetchTrendingVocabs()
                
                trendingVocabViewModel.subscribeToCloudKitDatabase()
            }
            .onReceive(NotificationCenter.default.publisher(for: .trendingUpdateNotification), perform: { _ in
                trendingVocabViewModel.fetchTrendingVocabs()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingVocabulariesView()
    }
}
