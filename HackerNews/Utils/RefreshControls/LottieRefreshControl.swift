//
//  LottieRefreshControl.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit
import Lottie

class LottieRefreshControl: UIRefreshControl {

    private var lottieView: AnimationView!
    private var isAnimating: Bool!
    private var maxPullHeight: CGFloat!
    
    override init() {
        super.init(frame: .zero)
        
        isAnimating = false
        maxPullHeight = 150.0
        lottieView = AnimationView(name: "BlueLoader")
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.loopMode = .loop
        addSubview(lottieView)
        let width: CGFloat = 40.0
        NSLayoutConstraint.activate([
            lottieView.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0.0),
            lottieView.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0.0),
            lottieView.widthAnchor.constraint(equalToConstant: width),
            lottieView.heightAnchor.constraint(equalToConstant: width)
        ])
        
        tintColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        
        isAnimating = true
        lottieView.currentProgress = 0
        lottieView.play()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        isAnimating = false
        lottieView.stop()
    }
    
    func updateProgress(with offsetY: CGFloat) {
        guard !isAnimating else { return }
        let progress = min(abs(offsetY / maxPullHeight), 1)
        let alpha = min(abs(offsetY / 50.0), 1)
        lottieView.currentProgress = progress
        lottieView.alpha = alpha
    }

}
