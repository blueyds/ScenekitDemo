// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "SceneKitTest12432",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "SceneKitTest12432",
            targets: ["AppModule"],
            teamIdentifier: "YNB2RNANFB",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bicycle),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .fileAccess(.userSelectedFiles, mode: .readOnly)
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)