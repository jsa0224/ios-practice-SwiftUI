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
                HStack {
                    VStack {
                        Text("🍓")
                        Text("\(viewStore.state.stock[0])")
                    }
                    .padding()

                    VStack {
                        Text("🍌")
                        Text("\(viewStore.state.stock[1])")
                    }
                    .padding()

                    VStack {
                        Text("🍍")
                        Text("\(viewStore.state.stock[2])")
                    }
                    .padding()

                    VStack {
                        Text("🥝")
                        Text("\(viewStore.state.stock[3])")
                    }
                    .padding()

                    VStack {
                        Text("🥭")
                        Text("\(viewStore.state.stock[4])")
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Juice Maker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {

                    } label: {
                        Image(systemName: "plus")
                    }
                }
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
