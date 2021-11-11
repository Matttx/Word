//
//  ContentView.swift
//  Word
//
//  Created by Matteo on 10/11/2021.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    
    @StateObject var viewModel = WordViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    SearchBar().environmentObject(viewModel)
                    
                    DefinitionSection()
                        .environmentObject(viewModel)
                    
                    FavoriteWordsSection()
                        .environmentObject(viewModel)
                        
                    RecentWordsSearchedSection()
                        .environmentObject(viewModel)
                }
            }
            .navigationTitle("Find a word")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.word.isEmpty && viewModel.details != nil && !viewModel.details!.isEmpty {
                        Button {
                            viewModel.updateFavorite()
                        } label: {
                            Text("\(viewModel.isFavorite(viewModel.word) ? "Remove" : "Add")" + " to favorites")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.clearDetails()
                    } label: {
                        Text("Clear")
                    }
                }
            }
            .toast(isPresenting: $viewModel.loadingDatas) {
                AlertToast(type: .loading)
            }
            .toast(isPresenting: $viewModel.showErrorToast){
                AlertToast(displayMode: .alert ,type: .error(Color(uiColor: .systemRed)), title: viewModel.error?.rawValue)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.colorScheme, .light)
    }
}
