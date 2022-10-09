//
//  MBCTextField.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

final class MBCTextField: UITextField {
    
    lazy var floatingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.zPosition = 1
        label.textAlignment = .center
        label.font = .init(name: C.Fonts.almaraiRegular, size: 15)
        label.textColor = .init(named: C.Colors.veryLightPink)?.withAlphaComponent(0.5)
        return label
    }()
    
    private var isUp: Bool = false {
        didSet {
            moveLabel(isUp)
        }
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        bindFloatingLabel()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        bezier()
//        addBorder(borderWidth: 1, borderColor: UIColor(named: C.Colors.brownishGreyTwo).unwrap)
    }
    
    convenience init(_ placeholder: String) {
        self.init()
        floatingLabel.text = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        backgroundColor = .clear
        textAlignment = .defaultAlignment
        font = .init(name: C.Fonts.almaraiRegular, size: 15)

        floatingLabel.place(on: self).pin(
            .centerY(),
            .leading(to: self, padding: 7),
            .fixedWidth(50)
        )
        
        bringSubviewToFront(floatingLabel)
    }
    
    private func bindFloatingLabel() {
        addTarget(self, action: #selector(start), for: .editingDidBegin)
        addTarget(self, action: #selector(end), for: .editingDidEnd)
    }
    
    private func moveLabel(_ isUp: Bool) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self else { return }
                if isUp {
                    let offsetX = self.floatingLabel.frame.width * 0.1
                    let translation = CGAffineTransform(translationX: -offsetX + 7, y: -self.frame.height/1.5)
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.floatingLabel.transform = translation.concatenating(scale)
                } else {
                    self.floatingLabel.transform = .identity
                }
            },
            completion: nil
        )
    }
    
    @objc
    private func start() {
        if !isUp {
            isUp.toggle()
        }
    }
    
    @objc
    private func end() {
        if isUp && text.isEmptyOrNil {
            isUp.toggle()
        }
    }
    
    func bezier() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
        
        let borderLayer = CAShapeLayer()
        
        borderLayer.path = path
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = UIColor(named: C.Colors.brownishGreyTwo).unwrap.cgColor
        
        borderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
    }

}

