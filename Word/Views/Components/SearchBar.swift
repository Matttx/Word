//
//  SearchBar.swift
//  Word
//
//  Created by Matteo on 10/11/2021.
//

import SwiftUI

struct SearchBar: View {
    @FocusState private var focusedField: Bool
    @EnvironmentObject private var viewModel: WordViewModel
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color(uiColor: .systemGray))
                TextField("Find a word", text: $viewModel.word)
                    .focused($focusedField)
                    .onSubmit {
                        viewModel.getWord(viewModel.word)
                        viewModel.updateRecentList()
                    }
                Spacer()
                if !viewModel.word.isEmpty {
                    Button(action: {
                        viewModel.word = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color(uiColor: .systemGray))
                    })
                }
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 7)
            .background(colorScheme == .dark ? Color(uiColor: .systemGray6) : Color(UIColor.systemGray5))
            .cornerRadius(10)
            if (focusedField) {
                Text("Annuler")
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .foregroundColor(Color(uiColor: .systemBlue))
                    .onTapGesture {
                        viewModel.word = ""
                        focusedField = false
                    }
            }
        }.listRowInsets(EdgeInsets())
        .listRowBackground(Color.white.opacity(0))
        .animation(.linear, value: focusedField)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
