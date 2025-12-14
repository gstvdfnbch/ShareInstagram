import SwiftUI
struct ContentView: View {
    private let shareUseCase = InstagramShareUseCase()

    var body: some View {
        VStack {
            Button("TEST: Open Instagram") {
                shareUseCase.testInstagram()
            }

            Button("Share to Stories") {
                shareUseCase.shareToStories()
            }

            Button("Share to Feed") {
                shareUseCase.shareToFeed()
            }
        }
    }
}

#Preview {
    ContentView()
}
