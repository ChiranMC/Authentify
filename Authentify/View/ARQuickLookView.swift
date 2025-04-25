//
//  ARQuickLookView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-24.
//


import SwiftUI
import QuickLook

struct ARQuickLookView: UIViewControllerRepresentable {
    let usdzFileName: String

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        context.coordinator.usdzFileName = usdzFileName
        return controller
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        var usdzFileName: String = ""

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            let fileName = usdzFileName.replacingOccurrences(of: ".usdz", with: "")
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "usdz") else {
                fatalError("USDZ file not found.")
            }
            return url as QLPreviewItem
        }
    }
}
