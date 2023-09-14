//
//  JuiceMakingView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/09/12.
//

import SwiftUI
import ComposableArchitecture

extension Animation {
    static func ripple() -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
    }
}

struct JuiceMakerView: View {
    let store: StoreOf<JuiceMaker>
    var juice: Juice
    @State private var isShowingDetailView = false
    @State private var isShakeImageView = false
    @State private var isEnoughStock = true
    @State private var isDeficientStock = true

    func ingredientText(_ shape: String, _ quantity: String) -> some View {
        HStack {
            Text(shape)
            Text(quantity)
        }
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 30) {
                Spacer()

                HStack{
                    ingredientText(juice.ingredient[0].0.shape, juice.ingredient[0].1.description)

                    if juice.isNumberOfIngredientRequiredTwo {
                        Text("/")
                        ingredientText(juice.ingredient[1].0.shape, juice.ingredient[1].1.description)
                    }
                }

                Image("믹서기")
                    .resizable()
                    .frame(width: 200, height: 200)
//                    .offset(x: isShakeImageView ? 10 : 0)
//                    .animation(.easeOut(duration: 0.5).repeatForever(autoreverses: isShakeImageView),
//                               value: isShakeImageView)
//                    .onTapGesture {
//                        isShakeImageView.toggle()
//                    }

                Spacer()

                Button {
//                    isShakeImageView = true
                    viewStore.send(.makingButtonTapped(juice: juice))
                    isEnoughStock = viewStore.state.isEnoughOfStock
                    isDeficientStock = !viewStore.state.isEnoughOfStock
                } label: {
                    Text("주문하기")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $isEnoughStock) {
                    Alert(title: Text("쥬스 재조 성공"),
                          dismissButton: .default(Text("확인")))
                } // 이 얼럿 안 나오는 중...ㅋ
                .alert(isPresented: $isDeficientStock) {
                    Alert(title: Text("쥬스 재조 실패"),
                          dismissButton: .default(Text("확인")))
                }

                Spacer()

                NavigationLink(destination: FruitStoreView(store: store), isActive: $isShowingDetailView) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationTitle("JuiceMaker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingDetailView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct JuiceMakingView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMakerView(store: Store(initialState: JuiceMaker.State()) {
            JuiceMaker()
                ._printChanges()
        }, juice: .mangoKiwiJuice)
    }
}
