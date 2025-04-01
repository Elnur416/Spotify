//
//  HomeUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

protocol HomeUseCase {
    func getNewRelease(completion: @escaping ((Albums?, String?) -> Void))
    func getTopArtists(completion: @escaping ((ArtistsClass?, String?) -> Void))
    func getTopTracks(completion: @escaping ((Tracks?, String?) -> Void))
    func getRecentlyTracks(completion: @escaping ((RecentlyTracks?, String?) -> Void))
}
