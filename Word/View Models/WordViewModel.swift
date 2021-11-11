//
//  WordViewModel.swift
//  Word
//
//  Created by Matteo on 10/11/2021.
//

import Foundation
import Alamofire
import AlertToast

class WordViewModel: ObservableObject {
    @Published var word = ""
    @Published var error: WordError? = nil
    @Published var details: [Details]? = nil
    @Published var loadingDatas = false
    @Published var showErrorToast = false
    @Published var recentWordsSearched = UserDefaults.standard.array(forKey: "recentWordsSearched") as? [String]
    @Published var favoriteWords = UserDefaults.standard.array(forKey: "favoriteWords") as? [String]
    
    func updateRecentList() {
        guard var recentWordsSearched = recentWordsSearched else {
            UserDefaults.standard.set([word], forKey: "recentWordsSearched")
            return
        }
        
        if recentWordsSearched.contains(where: { word in
            self.word == word
        }) {
            // Put the word in the top position
            recentWordsSearched = recentWordsSearched.filter { $0 != word }
            recentWordsSearched.insert(word, at: 0)
        } else {
            // Get only the 10th last recent words
            recentWordsSearched.insert(word, at: 0)
            if recentWordsSearched.count > 10 {
                _ = recentWordsSearched.popLast()
            }
        }
        UserDefaults.standard.set(recentWordsSearched, forKey: "recentWordsSearched")
        self.recentWordsSearched = recentWordsSearched
        return
    }
    
    func updateFavorite(_ w: String = "") {
        let word = w.isEmpty ? self.word : w
        
        guard var favoriteWords = favoriteWords else {
            UserDefaults.standard.set([word], forKey: "favoriteWords")
            return
        }
        
        if isFavorite(word) {
            favoriteWords = favoriteWords.filter { $0 != word }
        } else {
            favoriteWords.append(word)
        }
        UserDefaults.standard.set(favoriteWords, forKey: "favoriteWords")
        self.favoriteWords = favoriteWords
        return
    }
    
    func isFavorite(_ word: String) -> Bool {
        guard let favoriteWords = favoriteWords else { return false }
        return favoriteWords.contains(where: { item in
            word == item
        })
    }
    
    func clearDetails() {
        details = nil
        word = ""
    }
    
    func isRecentWordsListIsDisplayable() -> Bool {
        return details == nil && recentWordsSearched != nil && !recentWordsSearched!.isEmpty
    }
    
    func isFavoriteWordsListIsDisplayable() -> Bool {
        return details == nil && favoriteWords != nil && !favoriteWords!.isEmpty
    }


    //MARK: - Word Service
    
    private let wordService: WordService
    init(wordService: WordService = WordService()) {
        self.wordService = wordService
    }
    
    func getWord(_ word: String) {
        loadingDatas = true
        wordService.getWord(word: word) { result in
            switch result {
                case .success(let details):
                    self.details = details
                    self.loadingDatas = false
                case .failure(let err):
                    self.error = err
                    self.loadingDatas = false
                    self.showErrorToast = true
            }
        }
    }
}
