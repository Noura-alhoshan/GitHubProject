//
//  Dynamic.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 04/01/2023.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    private var willCallListener: Bool = true
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    var value: T {
        didSet {
            guard willCallListener else { return }
            listener?(value)
        }
    }
    init(value: T) {
        self.value = value
    }
    func beginSafeModify() {
        willCallListener = false
    }
    func endSafeModify() {
        willCallListener = true
    }
}
