//
//  EmptyStateTableViewCell.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 27/3/2023.
//

import UIKit
import Lottie

class EmptyStateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animationView: LottieAnimationView!

    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.animation = LottieAnimation.named("taskman")
        animationView.loopMode = .loop
        animationView.play()
    }

    

}
