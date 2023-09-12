//
//  JuiceMakerApp.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

@main
struct JuiceMakerApp: App {
    var body: some Scene {
        WindowGroup {
            JuiceListView(store: Store(initialState: JuiceMaker.State()) {
                JuiceMaker()
                    ._printChanges()
            })
        }
    }
}
