//
//  JuiceMenuView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/09/12.
//

import SwiftUI
import ComposableArchitecture

struct JuiceMenuView: View {
    var juice: Juice

    var body: some View {
        HStack {
            juice.image
                .resizable()
                .frame(width: 60, height: 60)
            Text(juice.name)

            Spacer()
        }
    }
}

struct JuiceMenuView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMenuView(juice: Juice.bananaJuice)
    }
}
