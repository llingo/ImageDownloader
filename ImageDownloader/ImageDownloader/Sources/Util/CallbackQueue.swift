//
//  CallbackQueue.swift
//  ImageDownloader
//

import Foundation

enum CallbackQueue {
    case asyncMain
    case asyncSafeMain
    case dispatch(DispatchQueue)
    case none

    func execute(_ block: @escaping () -> Void) {
        switch self {
        case .asyncMain:
            DispatchQueue.main.async { block() }
        case .asyncSafeMain:
            DispatchQueue.main.asyncSafe { block() }
        case .dispatch(let queue):
            queue.async { block() }
        case .none:
            block()
        }
    }
}

// MARK: - Extension

extension DispatchQueue {
    func asyncSafe(_ block: @escaping () -> Void) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
