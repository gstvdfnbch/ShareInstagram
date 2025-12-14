import UIKit

final class InstagramShareUseCase {

    private let storiesClient = InstagramStoriesClient()
    private let feedClient = InstagramFeedClient()

    func testInstagram() {
        storiesClient.testInstagramAvailability()
    }

    func shareToStories() {
        storiesClient.share(image: sharedImage())
    }

    func shareToFeed() {
        feedClient.share(image: sharedImage())
    }

    private func sharedImage() -> UIImage? {
        UIImage(named: "image")
    }
}
