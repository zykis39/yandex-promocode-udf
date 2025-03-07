//
//  State.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//
import UDF

struct AppState: AppReducer & Equatable {
    var reducer = PromocodeReducer()
}
