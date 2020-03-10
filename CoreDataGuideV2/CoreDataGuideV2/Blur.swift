//
//  Blur.swift
//  CoreDataGuideV2
//
//  Created by Edward Lucas-Rowe on 26/02/2020.
//  Copyright © 2020 Edward Lucas-Rowe. All rights reserved.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
