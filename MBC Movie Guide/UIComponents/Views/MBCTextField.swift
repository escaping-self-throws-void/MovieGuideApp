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
        
//        layer.cornerRadius = 4
//        layer.borderWidth = 1
//        layer.borderColor = UIColor(named: C.Colors.brownishGreyTwo).unwrap.cgColor
        clipsToBounds = false

        addBorders(with: UIColor(named: C.Colors.brownishGreyTwo), borderWidth: 1)
        
        floatingLabel.place(on: self).pin(
            .centerY(),
            .leading(to: self, padding: 7)
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
    
    
    func addBorders(with color: UIColor?, borderWidth: CGFloat) {
        addTopBorder(with: color, andWidth: borderWidth)
        addBottomBorder(with: color, andWidth: borderWidth)
        addLeftBorder(with: color, andWidth: borderWidth)
        addRightBorder(with: color, andWidth: borderWidth)
    }
    
    
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }

}

