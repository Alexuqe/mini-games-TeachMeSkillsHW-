//
//  MovingTheCircleViewController.swift
//  Tap Circle (TeachMeSkillsHW)
//
//  Created by Sasha on 15.12.24.
//

import UIKit

class MovingTheCircleViewController: UIViewController {

    let circle = UIView()
    let sizeOfCircle = 80

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Moving Circle"

        setupUI()
    }

}

private extension MovingTheCircleViewController {
    func setupUI() {
        configureCircleView()

        movingCircle()
    }

    func configureCircleView() {
        circle.backgroundColor = .systemYellow
        circle.frame = CGRect(x: 100, y: 100, width: sizeOfCircle, height: sizeOfCircle)
        circle.layer.cornerRadius = circle.frame.height / 2
        view.addSubview(circle)
    }

    func movingCircle() {
        let movingRegonizer = UIPanGestureRecognizer(target: self, action: #selector(moveCircle(_ :)))
        circle.addGestureRecognizer(movingRegonizer)

    }

    @objc func moveCircle(_ gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: circle)

        if circle.frame.origin.x < view.frame.origin.x + 2 || circle.frame.origin.y < view.frame.origin.y {
            circle.center = CGPoint(x: circle.center.x + 3 , y: circle.center.y + 3)
        } else if circle.frame.maxX > view.frame.width || circle.frame.maxY > view.frame.height {
            circle.center = CGPoint(x: circle.center.x - 3, y: circle.center.y - 3)
        }

        circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
        gesture.setTranslation(.zero, in: circle)
    }



}

#Preview {
    let view = MovingTheCircleViewController()
    view
}
