//
//  ContentView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct JuiceMakerView: View {
    let store: StoreOf<JuiceMaker>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.juices, id: \.self) { juice in
                        NavigationLink {
                            FruitStoreView(store: store)
                        } label: {
                            JuiceMenuView(juice: juice)
                        }
                    }
                }
                .navigationTitle("Juice Maker")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMakerView(store: Store(initialState: JuiceMaker.State()) {
            JuiceMaker()
                ._printChanges()
        })
    }
}
