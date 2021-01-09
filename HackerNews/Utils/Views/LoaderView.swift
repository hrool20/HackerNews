//
//  LoaderView.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit
import Lottie

class LoaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    private var lottieView: AnimationView!
    private var animationDuration: TimeInterval!
    static var isVisible: Bool = false
    
    init(message: String, animationDuration: TimeInterval? = 1.0) {
        super.init(frame: UIScreen.main.bounds)
        
        self.animationDuration = animationDuration
        loadNIB()
        
        start(message: message)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNIB()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadNIB()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstView.backgroundColor = .loaderBackgroundColor
        messageLabel.textColor = .textColor
        firstView.layer.cornerRadius = firstView.bounds.width / 20
    }
    
    private func start(message: String) {
        lottieView = AnimationView(name: (traitCollection.userInterfaceStyle == .dark) ? "BlueLoaderDark" : "BlueLoader")
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.loopMode = .loop
        lottieView.animationSpeed = CGFloat(animationDuration)
        animationView.addSubview(lottieView!)
        NSLayoutConstraint.activate([
            lottieView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor, constant: 0),
            lottieView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 0),
            lottieView.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 0),
            lottieView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 0)
        ])
        
        LoaderView.isVisible = true
        alpha = 0.0
        firstView.transform = CGAffineTransform(scaleX: 0, y: 0)
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.2) {
                self?.alpha = 1.0
                self?.layoutIfNeeded()
            }
            UIView.animate(withDuration: 0.3) {
                self?.firstView.transform = .identity
            }
        }
        lottieView.play()
        loadViews(message: message, animation: false)
    }
    
    func loadViews(message: String, animation shouldAnimate: Bool) {
        messageLabel.text = message
        guard shouldAnimate else { return }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: { [weak self] in
            self?.layoutIfNeeded()
        }) { (_) in
        }
    }
    
    func hide() {
        removeFromSuperview()
        LoaderView.isVisible = false
    }
    
    private func loadNIB() {
        Bundle.main.loadNibNamed(LoaderView.NIBName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
