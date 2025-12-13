import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Button("TEST: Open Instagram") {
                testInstagramOpen()
            }
            .buttonStyle(.bordered)

            Text("Instagram Share Demo")
                .font(.title)
                .bold()

            Button("Share to Instagram Stories") {
                shareToInstagramStories()
            }
            .buttonStyle(.borderedProminent)

            Button("Share to Instagram Feed") {
                shareToInstagramFeed()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }

    private let instagramAppId = "AQUI_APP_ID_FACEBOOK"

    func sharedImage() -> UIImage? {
        UIImage(named: "image")
    }

    func log(_ message: String) {
        print("[InstagramShare] \(message)")
    }

    func testInstagramOpen() {
        log("Testing instagram:// availability")
        guard let url = URL(string: "instagram://") else {
            log("Invalid instagram:// URL")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            log("Instagram is available, opening app")
            UIApplication.shared.open(url)
        } else {
            log("Instagram is NOT available (canOpenURL = false)")
        }
    }

    // MARK: - Instagram Stories

    func shareToInstagramStories() {
        log("Share to Stories tapped")

        guard let image = sharedImage() else {
            log("Asset 'share_image' NOT found")
            return
        }

        guard let pngData = image.pngData() else {
            log("Failed to convert image to PNG")
            return
        }

        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.stickerImage": pngData,
            "com.instagram.sharedSticker.backgroundTopColor": "#FFCC00",
            "com.instagram.sharedSticker.backgroundBottomColor": "#FF8800"
        ]

        log("Writing data to UIPasteboard")
        UIPasteboard.general.setItems(
            [pasteboardItems],
            options: [.expirationDate: Date().addingTimeInterval(300)]
        )

        let urlString = "instagram-stories://share?source_application=\(instagramAppId)"
        log("Opening URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            log("Invalid stories URL")
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            log("Instagram Stories URL available, opening")
            UIApplication.shared.open(url)
        } else {
            log("Instagram Stories URL NOT available")
        }
    }

    // MARK: - Instagram Feed

    func shareToInstagramFeed() {
        log("Share to Feed tapped")

        guard let image = sharedImage() else {
            log("Asset 'share_image' NOT found")
            return
        }

        log("Saving image to Photos")
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let urlString = "instagram://library"
            log("Opening URL: \(urlString)")

            guard let url = URL(string: urlString) else {
                log("Invalid instagram://library URL")
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                log("Instagram Feed URL available, opening")
                UIApplication.shared.open(url)
            } else {
                log("Instagram Feed URL NOT available")
            }
        }
    }
}

#Preview {
    ContentView()
}
