//
//  ViewController.swift
//  EmojiPicker
//
//  Created by Егор Бадмаев on 14.01.2023.
//  Copyright (c) 2023 Егор Бадмаев. All rights reserved.
//

import UIKit
import EmojiPicker

class ViewController: UIViewController {
    
    private lazy var emojiButton: UIButton = {
        let button = UIButton()
        button.setTitle("😃", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        button.addTarget(self, action: #selector(openEmojiPickerModule), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var presentAsPageSheetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present as Page Sheet", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.addTarget(self, action: #selector(openEmojiPickerModuleAsPageSheet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @objc private func openEmojiPickerModule(sender: UIButton) {
        let viewController = EmojiPickerViewController()
        viewController.delegate = self
        viewController.sourceView = sender
        present(viewController, animated: true)
    }
    
    @objc private func openEmojiPickerModuleAsPageSheet(sender: UIButton) {
        let viewController = EmojiPickerViewController(modalPresentationStyle: .pageSheet)
        viewController.delegate = self
        if #available(iOS 15.0, *) {
            if let sheet = viewController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
        present(viewController, animated: true)
    }
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(emojiButton)
        view.addSubview(presentAsPageSheetButton)
        
        NSLayoutConstraint.activate([
            emojiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            emojiButton.heightAnchor.constraint(equalToConstant: 80),
            emojiButton.widthAnchor.constraint(equalToConstant: 80),
            presentAsPageSheetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentAsPageSheetButton.topAnchor.constraint(equalTo: emojiButton.bottomAnchor, constant: 60)
        ])
    }
}

// MARK: - EmojiPickerDelegate

extension ViewController: EmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiButton.setTitle(emoji, for: .normal)
    }
}
