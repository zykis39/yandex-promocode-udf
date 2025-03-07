//
//  Component.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import SwiftUI
import UDF

struct PromocodeComponent: Component {
    struct Props {
        var promocode: String
        @Binding var shareBottomSheetPresented: Bool
        var onLeftTapped: () -> Void
        var onRightTapped: () -> Void
        var onShareTapped: () -> Void
    }
    
    var props: Props
    
    var body: some View {
        Spacer()
            .frame(height: 80)
        VStack {
            Text("Поделись промокодом с другом!")
                .font(.system(size: 20))
            Spacer()
            HStack {
                Button { props.onLeftTapped() } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                }.tint(.gray)
                Spacer()
                Text(props.promocode)
                    .font(.system(size: 24))
                Spacer()
                Button { props.onRightTapped() } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                }.tint(.gray)
            }
            Spacer()
            Button { props.onShareTapped() } label: {
                Text("Поделиться")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
            }
            .tint(.black)
            .buttonStyle(.bordered)
            .clipShape(.buttonBorder)
            
        }
        .padding(16)
        .sheet(isPresented: props.$shareBottomSheetPresented, content: {
            ActivityViewController(activityItems: [String(props.promocode)])
        })
    }
}

#Preview {
    PromocodeComponent(
        props: .init(
            promocode: "SLDJFUSQW",
            shareBottomSheetPresented: .init(get: { false }, set: { _ in }),
            onLeftTapped: {},
            onRightTapped: {},
            onShareTapped: {}
        )
    )
}
