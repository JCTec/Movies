//
//  SearchField.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public protocol SearchFieldDelegate: class {
    func didChangeText()
    func didClearText()
}

public class SearchField: UIView {

    public var placeholderText: String!
    public var searchImage: UIImage!
    public var background: UIColor!
    public var clearImage: UIImage!
    private var searchImageView: UIImageView!
    private var clearImageView: UIImageView!
    private var containerView: UIView!
    private var textField: UITextField!
    private var mainStack: UIStackView!
    private var verticalStackForClear: UIStackView!
    private var verticalTopViewForClear: UIView!
    private var verticalBottomViewForClear: UIView!

    public weak var delegate: SearchFieldDelegate?

    public init(placeholderText: String, searchImage: UIImage = #imageLiteral(resourceName: "search.pdf"), background: UIColor = .white, clearImage: UIImage = #imageLiteral(resourceName: "exit")) {
        super.init(frame: CGRect.zero)

        self.placeholderText = placeholderText
        self.searchImage = searchImage
        self.background = background
        self.clearImage = clearImage

        isOpaque = false
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)

        containerView.backgroundColor = background
        containerView.layer.cornerRadius = 15.0

        searchImageView = UIImageView(image: searchImage)
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.contentMode = .scaleAspectFit

        let clearText = UITapGestureRecognizer(target: self, action: #selector(didSelectClear))
        clearText.cancelsTouchesInView = true

        clearImageView = UIImageView(image: clearImage)
        clearImageView.translatesAutoresizingMaskIntoConstraints = false
        clearImageView.contentMode = .scaleAspectFit
        clearImageView.isUserInteractionEnabled = true
        clearImageView.addGestureRecognizer(clearText)

        verticalTopViewForClear = UIView()
        verticalTopViewForClear.backgroundColor = .clear

        verticalBottomViewForClear = UIView()
        verticalBottomViewForClear.backgroundColor = .clear

        verticalStackForClear = UIStackView(arrangedSubviews: [
            verticalTopViewForClear,
            clearImageView,
            verticalBottomViewForClear
        ])
        verticalStackForClear.axis = .vertical
        verticalStackForClear.alignment = .center

        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(didChangeText), for: UIControl.Event.editingChanged)
        textField.returnKeyType = .search
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: Raleway.regular.font(size: 15)
        ])

        mainStack = UIStackView(arrangedSubviews: [searchImageView, textField, verticalStackForClear])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.spacing = 6.0
        containerView.addSubview(mainStack)

        ShadowHelper.setShadow(to: containerView)

        addConstraints()

        clearImageView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

    public func mainTextField() -> UITextField {
        return textField
    }

    public func getText() -> String {
        let text = textField.text?.trim() ?? ""
        return text
    }

    @objc public func didChangeText() {
        if (textField.text ?? "").isEmpty {
            clearImageView.isHidden = true
        } else {
            clearImageView.isHidden = false
        }

        delegate?.didChangeText()
    }

    @objc public func didSelectClear() {
        textField.text = ""
        clearImageView.isHidden = true
        delegate?.didClearText()
    }

    public func addConstraints() {
        NSLayoutConstraint.activate([
            searchImageView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, constant: 0.0),
            searchImageView.widthAnchor.constraint(equalToConstant: 20.0),

            verticalStackForClear.widthAnchor.constraint(equalToConstant: 20.0),

            textField.heightAnchor.constraint(equalTo: mainStack.heightAnchor, constant: 0.0),

            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),

            mainStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2.0),
            mainStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2.0),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0)
        ])
    }
}
