import UIKit

final class InstagramFeedClient {

    func share(image: UIImage?) {
        guard let image = image else {
            log("Invalid image")
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let url = URL(string: "instagram://library")!
            UIApplication.shared.open(url)
        }
    }

    private func log(_ message: String) {
        print("[InstagramFeed] \(message)")
    }
}
