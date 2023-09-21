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

                Spacer()

                Button {
                    viewStore.send(.makingButtonTapped(juice: juice))
                } label: {
                    Text("주문하기")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                } // TODO: 얼럿 2개 이상이 같은 버튼에 붙어 있으면 안 되는 버그가 있는데 어떻게 해결할까? -> 1. ViewModifier - 실패..
//                .alert(isPresented: viewStore.binding(get: \.isEnoughOfStock,
//                                                      send: { .isEnoughFruit(isEnough: $0) })) {
//                    Alert(title: Text("쥬스 재조 성공"),
//                          dismissButton: .default(Text("확인")))
//
//                }
                .alert("쥬스 재조 실패", isPresented: viewStore.binding(get: \.isDeficientOfStock,
                                                                    send: { .isDeficientFruit(isDeficient: $0) })) {
                        Button("과일 재고 추가") {
                            viewStore.send(.confirmButtonTapped(isConfirmButtonTapped: true))
                        }
                        Button("취소") {
                            viewStore.send(.cancelButtonTapped)
                        }
                }

                Spacer()

                NavigationLink(destination: FruitStoreView(store: store),
                               isActive: viewStore.binding(get: \.isShowingDetailView,
                                                           send: { .confirmButtonTapped(isConfirmButtonTapped: $0) })) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationTitle("JuiceMaker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewStore.send(.confirmButtonTapped(isConfirmButtonTapped: true))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .padding()
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
