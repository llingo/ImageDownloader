//
//  ImageDownloader.swift
//  ImageDownloader
//

import Foundation

enum ImageDownloadError: Error {
    case failed
}

final class ImageDownloader {

    static let shared = ImageDownloader()
    private var session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    func setImage(
        with url: URL,
        callbackQueue: CallbackQueue = .asyncSafeMain,
        completionHandler completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {

        let callback = { (result: Result<Data, Error>) in
            callbackQueue.execute { completion(result) }
        }

        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(ImageDownloadError.failed))
                return
            }

            guard (200..<300).contains(response.statusCode) else {
                callback(.failure(ImageDownloadError.failed))
                return
            }

            guard error == nil else {
                callback(.failure(ImageDownloadError.failed))
                return
            }

            guard let data else {
                callback(.failure(ImageDownloadError.failed))
                return
            }

            callback(.success(data))
        }

        return task
    }
}
