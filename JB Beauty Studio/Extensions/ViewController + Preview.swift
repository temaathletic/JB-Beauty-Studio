//
//  ViewController + Preview.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 11.01.2023.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 15, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self)
    }
}
#endif
