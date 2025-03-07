import ProjectDescription

let project = Project(
    name: "yandex-promocode-udf",
    targets: [
        .target(
            name: "yandex-promocode-udf",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.yandex-promocode-udf",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["yandex-promocode-udf/Sources/**"],
            resources: ["yandex-promocode-udf/Resources/**"],
            dependencies: [
                .external(name: "UDF")
            ]
        )
    ]
)
