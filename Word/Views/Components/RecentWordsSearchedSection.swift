//
//  RecentWordsSearchedSection.swift
//  Word
//
//  Created by Matteo on 11/11/2021.
//

import SwiftUI

struct RecentWordsSearchedSection: View {
    
    @EnvironmentObject var viewModel: WordViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    func removeRecentRow(at offsets: IndexSet) {
        viewModel.recentWordsSearched!.remove(atOffsets: offsets)
        UserDefaults.standard.set(viewModel.recentWordsSearched, forKey: "recentWordsSearched")
    }
    
    var body: some View {
        if viewModel.isRecentWordsListIsDisplayable() {
            Section {
                ForEach(viewModel.recentWordsSearched!, id: \.self) { item in
                    Button {
                        viewModel.word = item
                        viewModel.getWord(item)
                        viewModel.updateRecentList()
                    } label: {
                        HStack {
                            Text(item)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            Spacer()
                            Button {
                                viewModel.updateFavorite(item)
                            } label: {
                                Image(systemName: viewModel.isFavorite(item) ? "heart.fill" : "heart")
                                    .foregroundColor(Color(uiColor: .systemBlue))
                            }
                        }
                    }
                }
                .onDelete(perform: removeRecentRow)
            } header: {
                Text("Recent Words")
            }
        }
    }
}

struct RecentWordsSearchedSection_Previews: PreviewProvider {
    static var previews: some View {
        RecentWordsSearchedSection()
    }
}
