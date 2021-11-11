//
//  FavoriteWordsSection.swift
//  Word
//
//  Created by Matteo on 11/11/2021.
//

import SwiftUI

struct FavoriteWordsSection: View {
    
    @EnvironmentObject var viewModel: WordViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    func removeFavoriteRow(at offsets: IndexSet) {
        viewModel.favoriteWords!.remove(atOffsets: offsets)
        UserDefaults.standard.set(viewModel.favoriteWords, forKey: "favoriteWords")
    }

    var body: some View {
        if viewModel.isFavoriteWordsListIsDisplayable() {
            Section {
                ForEach(viewModel.favoriteWords!, id: \.self) { item in
                    Button {
                        viewModel.word = item
                        viewModel.getWord(item)
                        viewModel.updateRecentList()
                    } label: {
                        Text(item)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
                .onDelete(perform: removeFavoriteRow)
            } header: {
                Text("Favorite Words")
            }
        }
    }
}

struct FavoriteWordsSection_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWordsSection()
    }
}
