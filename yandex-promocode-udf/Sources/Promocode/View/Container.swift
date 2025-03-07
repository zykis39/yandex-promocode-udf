//
//  Container.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import SwiftUI
import UDF

struct PromocodeContainer: Container {
    typealias ContainerComponent = PromocodeComponent
    
    func scope(for state: AppState) -> Scope {
        state
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        guard let promocode = store.state.reducer.selectedPromocode else {
            return .init(promocode: "",
                         shareBottomSheetPresented: .init(get: { false }, set: { _ in }),
                         onLeftTapped: {},
                         onRightTapped: {},
                         onShareTapped: {})
        }
        
        return .init(promocode: promocode.value,
                     shareBottomSheetPresented: .init(get: { store.state.reducer.shareState == .presented },
                                                      set: { presented in setBottomSheetVisible(presented) }),
                     onLeftTapped: {
            onLeftTapped()
        }, onRightTapped: {
            onRightTapped()
        }, onShareTapped: {
            onShareTapped()
        })
    }
    
    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPromocodes())
    }
    
    // MARK: - View Actions
    private func onLeftTapped() {
        store.dispatch(Actions.ChangePromocodeTapped(direction: .left))
    }
    
    private func onRightTapped() {
        store.dispatch(Actions.ChangePromocodeTapped(direction: .right))
    }
    
    private func onShareTapped() {
        store.dispatch(Actions.PromocodeShareTapped())
    }
    
    private func setBottomSheetVisible(_ visible: Bool) {
        store.dispatch(Actions.SetBottomSheetVisible(visible: visible))
    }
}
