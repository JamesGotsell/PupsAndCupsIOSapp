import SwiftUI

struct BusinessRewardsView: View {
    @ObservedObject var viewModel: BusinessDetailViewModel
    let pointsBalance: Int

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        Group {
            if viewModel.isLoadingRewards && viewModel.rewards.isEmpty {
                LoadingView()
            } else if viewModel.rewards.isEmpty {
                emptyState
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.rewards) { reward in
                            RewardCardView(
                                reward: reward,
                                canRedeem: pointsBalance >= reward.pointsCost
                            ) {
                                Task { await viewModel.redeemReward(reward) }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await viewModel.loadRewards()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "gift")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("No Rewards Available")
                .font(.title3.weight(.semibold))
            Text("Check back later for rewards from this business.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
