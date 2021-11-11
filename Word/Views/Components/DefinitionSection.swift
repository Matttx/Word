//
//  DefinitionSection.swift
//  Word
//
//  Created by Matteo on 11/11/2021.
//

import SwiftUI

struct DefinitionSection: View {
    
    @EnvironmentObject var viewModel: WordViewModel

    var body: some View {
        if viewModel.details != nil {
            Section {
                List(viewModel.details!, id: \.definition) { item in
                    NavigationLink(destination: DetailsView( details: item).environmentObject(viewModel)) {
                        Text(item.definition.firstUppercased)
                            .padding(.vertical, 3)
                    }
                }
            } header: {
                Text("Definitions")
            }
        }
    }
}

struct DefinitionSection_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionSection()
    }
}
