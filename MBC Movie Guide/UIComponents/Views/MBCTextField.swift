//
//  MBCTextField.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

final class MBCTextField: UITextField {
    
    // MARK: - Outlets
    
    private lazy var floatingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .defaultAlignment
        label.font = .init(name: C.Fonts.almaraiRegular, size: 15)
        label.textColor = .init(named: C.Colors.veryLightPink)?.withAlphaComponent(0.5)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .defaultAlignment
        label.font = .init(name: C.Fonts.almaraiRegular, size: 8)
        label.textColor = .init(named: C.Colors.dustyRed)
        label.isHidden = true
        return label
    }()

    private lazy var defaultPath: UIBezierPath = {
        let path = UIBezierPath()
        let radius: CGFloat = 4
        
        path.move(to: CGPoint(x: 0, y: bounds.height - radius))
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: radius), radius: radius, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: bounds.height - radius), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: radius, y: bounds.height - radius), radius: radius, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        path.close()
        
        return path
    }()
    
    private lazy var floatingPath: UIBezierPath = {
        let path = UIBezierPath()
        let radius: CGFloat = 4

        let minXOffset = floatingLabel.frame.width * 0.02
        let maxXOffset = floatingLabel.frame.maxX - (floatingLabel.frame.width * 0.18)
        
        path.move(to: CGPoint(x: 0, y: bounds.height - radius))
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        path.addLine(to: .init(x: LanguageService.shared.isEn ? (padding + minXOffset - 3) : (maxXOffset + 3) - (floatingLabel.frame.width - minXOffset) + 3, y: 0))
        path.addClip()
        path.move(to: .init(x: maxXOffset + 3, y: 0))
        path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: radius), radius: radius, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: bounds.height - radius), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: radius, y: bounds.height - radius), radius: radius, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        
        return path
    }()
    
    private lazy var borderLayer: CAShapeLayer = {
        let borderLayer = CAShapeLayer()
        
        borderLayer.path = defaultPath.cgPath
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = UIColor(named: C.Colors.brownishGreyTwo).unwrap.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        return borderLayer
    }()
    
    // MARK: - Properties
    
    private var isUp: Bool = false {
        didSet {
            animateBorders(isUp)
            moveLabel(isUp)
        }
    }
    
    private var regex: RegexType? {
        didSet {
            addTarget(self, action: #selector(validateText), for: .editingChanged)
        }
    }
    
    private let padding: CGFloat = 7
    
    // MARK: - Super methods
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: .init(top: 0, left: padding, bottom: 0, right: padding))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: .init(top: 0, left: padding, bottom: 0, right: padding))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: .init(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10

        return rect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 10

        return rect
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.addSublayer(borderLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pinSubviews()
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        bindFloatingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with form: FormType) {
        floatingLabel.text = form.placeholder
        keyboardType = form.keyboard
        textContentType = form.keyboardContent
        addAccessoryView(form.accessoryButton)
        isSecureTextEntry = form.isSecure
        regex = form.regex
    }
    
    // MARK: - Private methods
    
    private func createUI() {
        backgroundColor = .clear
        textAlignment = .defaultAlignment
        font = .init(name: C.Fonts.almaraiRegular, size: 15)
    }
    
    private func pinSubviews() {
        floatingLabel.place(on: self).pin(
            .centerY(),
            .leading(to: self, padding: padding)
        )
        
        errorLabel.place(on: self).pin(
            .bottom(to: self, padding: -12),
            .leading(to: self)
        )
    }
    
    // TODO: Finish implementation
    private func addAccessoryView(_ view: UIView?) {
        rightView = view
        rightViewMode = .always
    }
    
    private func bindFloatingLabel() {
        addTarget(self, action: #selector(startFloating), for: .editingDidBegin)
        addTarget(self, action: #selector(endFloating), for: .editingDidEnd)
    }
    
    // MARK: - Animations
    
    private func moveLabel(_ isUp: Bool) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                if isUp {
                    let offsetX = self.floatingLabel.frame.width * 0.1
                    let translation = CGAffineTransform(translationX: -offsetX, y: -self.frame.height/1.5)
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.floatingLabel.transform = translation.concatenating(scale)
                } else {
                    self.floatingLabel.transform = .identity
                }
            },
            completion: nil
        )
    }
    
    private func animateBorders(_ isUp: Bool) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.toValue = isUp ? floatingPath.cgPath : defaultPath.cgPath
        animation.duration = 0.0001
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        borderLayer.add(animation, forKey: "path")
    }
    
    @objc private func startFloating() {
        if !isUp {
            isUp.toggle()
        }
    }
    
    @objc private func endFloating() {
        if isUp && text.isEmptyOrNil {
            isUp.toggle()
        }
    }
    
    @objc private func validateText() {
        guard let regex = regex, let text = text, !text.isEmpty else { return }
        let isValid = text.validate(by: regex)
        let color = isValid ? UIColor(named: C.Colors.brownishGreyTwo)
                            : UIColor(named: C.Colors.dustyRed)
        errorLabel.isHidden = isValid
        errorLabel.text = regex.errorMessage
        borderLayer.strokeColor = color.unwrap.cgColor
        floatingLabel.textColor = color
    }
     
}

