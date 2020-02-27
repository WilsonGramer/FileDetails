// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "FileDetails",
    products: [
        .executable(name: "filedetails", targets: ["FileDetails"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yaslab/CSV.swift.git", from: "2.4.2"),
        .package(url: "https://github.com/JohnSundell/Files.git", from: "4.1.1"),
    ],
    targets: [
        .target(name: "FileDetails", dependencies: [
            "CSV",
            "Files",
        ]),
    ]
)
