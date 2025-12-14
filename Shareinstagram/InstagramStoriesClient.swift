import UIKit

final class InstagramStoriesClient {

    private let appId = "SEU_FACEBOOK_APP_ID"

    func testInstagramAvailability() {
        log("Testing instagram://")
        if UIApplication.shared.canOpenURL(URL(string: "instagram://")!) {
            log("Instagram available")
        } else {
            log("Instagram NOT available")
        }
    }

    func share(image: UIImage?, background: UIImage?) {
        guard let sticker = image,
              let stickerData = sticker.pngData() else {
            log("Invalid sticker image")
            return
        }

        var pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.stickerImage": stickerData,
            "com.instagram.sharedSticker.backgroundTopColor": "#FFCC00",
            "com.instagram.sharedSticker.backgroundBottomColor": "#FF8800"
        ]

        if let background = background,
           let backgroundData = background.pngData() {
            pasteboardItems["com.instagram.sharedSticker.backgroundImage"] = backgroundData
        }

        UIPasteboard.general.setItems(
            [pasteboardItems],
            options: [.expirationDate: Date().addingTimeInterval(300)]
        )

        let url = URL(
            string: "instagram-stories://share?source_application=\(appId)"
        )!

        UIApplication.shared.open(url)
    }
    
    private func log(_ message: String) {
        print("[InstagramStories] \(message)")
    }
}
