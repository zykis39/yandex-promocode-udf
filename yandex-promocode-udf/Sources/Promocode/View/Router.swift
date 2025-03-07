//
//  Router.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import SwiftUI
import UDF

struct PromocodeRouting: Routing {
    enum Route: Hashable {
        case some
    }
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .some: Text("Some")
        }
    }
}
