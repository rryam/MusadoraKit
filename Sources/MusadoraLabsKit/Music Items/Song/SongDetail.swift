//
//  SongDetail.swift
//  SongDetail
//
//  Created by Rudrank Riyam on 22/07/22.
//

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *, macOS 14.0, macCatalyst 17.0, *)
extension Song {
  public func detail(for type: SongPropertyType) -> String? {
    switch type {
      case .id:
        return id.rawValue
      case .title:
        return title
      case .albumTitle:
        return albumTitle
      case .artistName:
        return artistName
      case .artistURL:
        return artistURL?.absoluteString
      case .url:
        return url?.absoluteString
      case .trackNumber:
        return trackNumber?.description
      case .artwork:
        return artwork?.description
      case .contentRating:
        return contentRating.debugDescription
      case .duration:
        return duration?.description
      case .editorialNotes:
        return editorialNotes?.description
      case .playParameters:
        return playParameters.debugDescription
      case .composerName:
        return composerName
      case .releaseDate:
        return releaseDate?.description
      case .isrc:
        return isrc
      case .hasLyrics:
        return hasLyrics.description
      case .discNumber:
        return discNumber?.description
      case .genreNames:
        return genreNames.description
      case .previewAssets:
        return previewAssets?.description
      case .audioVariants:
        return audioVariants?.description
      case .isAppleDigitalMaster:
        return isAppleDigitalMaster?.description
      case .lastPlayedDate:
        return lastPlayedDate?.description
      case .libraryAddedDate:
        return libraryAddedDate?.description
      case .playCount:
        return playCount?.description
      case .albums:
        return albums?.description
      case .artists:
        return artists?.description
      case .composers:
        return composers?.description
      case .genres:
        return genres?.description
      case .musicVideos:
        return musicVideos?.description
      case .station:
        return station?.description
      case .attribution:
        return attribution
      case .movementCount:
        return movementCount?.description
      case .movementName:
        return movementName
      case .movementNumber:
        return movementNumber?.description
      case .workName:
        return workName
    }
  }
}
