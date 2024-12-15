    //
    //  ViewController.swift
    //  Tap Circle (TeachMeSkillsHW)
    //
    //  Created by Sasha on 15.12.24.
    //

import UIKit

final class TapCircleViewController: UIViewController {

    let navBarButton = UIBarButtonItem()

    private let circleSize = 70
    private var circles: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tap Circle"

        setupUI()
    }

}

    // MARK: - UI Setup
private extension TapCircleViewController {
    func setupUI() {
        setupGestureRecognizer()
    }

    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

}

    // MARK: - Circle Management
private extension TapCircleViewController {

    func createCircle(at point: CGPoint) {
        let circle = createCircleView()
        positionCircle(circle, at: point)
        addCircleToView(circle)
        handleIntersections()
    }

    func createCircleView() -> UIView {
        let circle = UIView()
        circle.backgroundColor = .red
        circle.frame.size = CGSize(width: circleSize, height: circleSize)
        circle.layer.cornerRadius = CGFloat(circleSize) / 2
        return circle
    }

    func positionCircle(_ circle: UIView, at point: CGPoint) {
        circle.center = point
    }

    func addCircleToView(_ circle: UIView) {
        view.addSubview(circle)
        circles.append(circle)
    }

    func handleIntersections() {
        let checkerCircles = checkerCircles()
        removeCircle(checkerCircles)
    }

    func checkerCircles() -> [UIView] {
        guard let lastCircle = circles.last else { return [] }
        return circles.filter { circle in
            circle !== lastCircle && // Исключаем последний круг из проверки
            circle.frame.intersects(lastCircle.frame) // Проверяем пересечение с последним
        }
    }

    func removeCircle(_ value: [UIView]) {
        value.forEach { circle in
            circle.removeFromSuperview()
            if let index = circles.firstIndex(of: circle) {
                circles.remove(at: index)
            }
        }

    }

        // MARK: - Gesture Handling
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else { return }
        let location = gesture.location(in: view)
        createCircle(at: location)
    }

}


#Preview {
    let view = TapCircleViewController()
    view
}

