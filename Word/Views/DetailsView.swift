//
//  DetailsView.swift
//  Word
//
//  Created by Matteo on 11/11/2021.
//

import SwiftUI

struct DetailsView: View {
    let details: Details
    
    @EnvironmentObject var viewModel: WordViewModel
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Text(details.definition.firstUppercased)
                        .padding(.vertical, 3)
                } header: {
                    Text("Definition")
                }
                
                Section {
                    Text(details.partOfSpeech.firstUppercased)
                } header: {
                    Text("Part of Speech")
                }
                
                Section {
                    if details.examples != nil {
                        ForEach(details.examples!, id: \.self) {
                            Text($0.firstUppercased)
                        }
                    } else {
                        Text("No example for this word").foregroundColor(Color(uiColor: .systemGray))
                    }
                } header: {
                    Text("Examples")
                }
                
                Section {
                    if details.synonyms != nil {
                        ForEach(details.synonyms!, id: \.self) {
                            Text($0.replacingOccurrences(of: "-", with: " ").firstUppercased)
                        }
                    } else {
                        Text("No synonyms for this word").foregroundColor(Color(uiColor: .systemGray))
                    }
                } header: {
                    Text("Synonyms")
                }
                
                Button {
                    viewModel.updateFavorite()
                } label: {
                    Text("\(viewModel.isFavorite(viewModel.word) ? "Remove" : "Add")" + " this word to my favorites")
                }
            }
        }
        .safeAreaInset(edge: .bottom) {}
        .navigationTitle(viewModel.word)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(details: Details(definition: "Ah", partOfSpeech: "a", synonyms: nil, examples: nil))
    }
}
