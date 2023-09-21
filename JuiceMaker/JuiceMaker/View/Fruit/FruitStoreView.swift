//
//  FruitStoreView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/09/12.
//

import SwiftUI
import ComposableArchitecture

// 굳이 과일 종류를 다 보여줄 필요가 있나?
// 음.. 해당 쥬스에 쓰이는 과일만 보여주고, 2개 이상이면 슬라이드 해서 추가할 수 있게 구현해보자요!

struct FruitStoreView: View {
    let store: StoreOf<JuiceMaker>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
    }
}

struct FruitStoreView_Previews: PreviewProvider {
    static var previews: some View {
        FruitStoreView(store: Store(initialState: JuiceMaker.State()) {
            JuiceMaker()
                ._printChanges()
        })
    }
}

