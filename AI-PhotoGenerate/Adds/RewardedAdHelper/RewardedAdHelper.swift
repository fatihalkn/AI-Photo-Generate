//
//  RewardedAdHelper.swift
//  AI-PhotoGenerate
//
//  Created by Fatih on 28.03.2024.
//

import Foundation
import GoogleMobileAds

class RewardedAdHelper: NSObject, GADFullScreenContentDelegate {
    private var rewardedAd: GADRewardedAd?
    
    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
                           request: request,
                           completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
            print("Rewarded ad loaded.")
        }
        )
    }
    
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadRewardedAd()
    }
    
    func showRewardedAd(viewController: UIViewController) {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
                let reward = self.rewardedAd?.adReward
                print("\(reward?.amount)")
            })
        }
        
    }
    
}
