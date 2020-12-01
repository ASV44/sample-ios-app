import UIKit
import youtube_ios_player_helper

final class LaunchDetailsHeaderView: UIView, NibLoadable {
    @IBOutlet private var youtubePlayerView: YTPlayerView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    func setup(with viewModel: LaunchDetailsHeaderViewModel) {
        descriptionLabel.text = viewModel.description
        youtubePlayerView.load(withVideoId: viewModel.videoID)
    }
}
