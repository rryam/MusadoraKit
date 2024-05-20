//
//  Album.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusicKit
import MusadoraKit

extension Album {
  static var mock: Album {
    get throws {
      let albumData = """
{
  "id": "1640832989",
  "type": "albums",
  "attributes": {
    "name": "SMITHEREENS",
    "artistName": "Joji"
  }
}
""".data(using: .utf8)

      guard let albumData else {
        throw URLError(.cannotDecodeRawData)
      }

      let album = try JSONDecoder().decode(Album.self, from: albumData)
      return album
    }
  }
}

extension HundredBestAlbum {
  static var mock: HundredBestAlbum {
    get throws {
      let albumData = """
{
    "sections": [
        {
            "sectionName": "tagline",
            "text": "Why choose between dancing and crying when you can do both?",
            "key": "100BestAlbums.BodyTalk.TaglineTextBlock"
        },
        {
            "sectionName": "blurb",
            "text": "Early on in her seventh full-length album—and international breakthrough—the Swedish pop star makes a declaration: “Fembots have feelings, too.” And, boy, does <i>Body Talk</i> have feelings. The album launched two of the 21st century’s definitive “sad bangers”—“Dancing on My Own” and “Call Your Girlfriend”—inspiring a wave of aching but triumphant crying-on-the-dance-floor anthems.",
            "key": "100BestAlbums.BodyTalk.BlurbTextBlock1"
        },
        {
            "sectionName": "image",
            "artwork": "https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/19/93/f1/1993f12d-5902-aca0-e07d-fba30f53a00f/1d4caf73-82e2-4f22-8c8d-2cd7e544e94b.png/2700x1800sr.png",
            "altText": "A photograph of Robyn.",
            "imageAltKey": "100BestAlbums.BodyTalk.ImageAltText",
            "imageAlt": "A photograph of Robyn."
        },
        {
            "sectionName": "blurb",
            "text": "But <i>Body Talk</i>’s emotional core is embodied by more than just those two instant classics. On “Love Kills” and “Hang With Me,” Robyn reminds listeners to steel themselves against the potential hurt and heartbreak of love. Alongside those considerable moments of vulnerability, there are also songs that teem with strutting, defiant confidence: the stark “Don’t Fucking Tell Me What to Do” and the bizarre but wonderful Snoop Dogg collaboration “U Should Know Better,” with its pulsing beats and playful boasting. (Few pop stars save for Robyn could successfully deliver a line like “Even the Vatican knows not to fuck with me.”) And every single track here is an airtight addition to the vision articulated on “Fembot”: This is an album that’s immaculate and poised, featuring a protagonist unafraid to bare her soul.",
            "key": "100BestAlbums.BodyTalk.BlurbTextBlock2"
        },
        {
            "sectionName": "pullQuote",
            "text": "“Any great pop writer will tell you that Robyn is a huge inspiration.”",
            "key": "100BestAlbums.BodyTalk.PullQuote",
            "attribution": "Niall Horan",
            "pullQuoteAttrKey": "100BestAlbums.BodyTalk.PullQuoteAttribution",
            "pullQuoteAttr": "Niall Horan"
        }
    ],
    "name": "Body Talk",
    "position": "100",
    "title": "Body Talk",
    "adamid": "1440714879",
    "primarybgcolor": "76DE92",
    "secondarybgcolor": "9fe8b3",
    "artwork": {
        "width": 1500,
        "url": "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/9e/66/3a/9e663ae4-4a96-31b4-147c-5ce1d555ff32/00602527569970.rgb.jpg/{w}x{h}bb.jpg",
        "height": 1500,
        "textColor3": "252527",
        "textColor2": "312421",
        "textColor4": "4c413f",
        "textColor1": "000103",
        "bgColor": "b7b7b7",
        "hasP3": false
    },
    "url": "https://music.apple.com/us/album/body-talk/1440714879",
    "artistName": "Robyn",
    "relationships": {
        "tracks": [
            {
                "id": "1440714973",
                "duration": 278080,
                "trackNumber": 1,
                "name": "Dancing On My Own (Radio Version)"
            },
            {
                "id": "1440714976",
                "duration": 214307,
                "trackNumber": 2,
                "name": "Fembot"
            },
            {
                "id": "1440714986",
                "duration": 249933,
                "trackNumber": 3,
                "name": "Don't F*****g Tell Me What to Do",
                "contentRating": "explicit"
            },
            {
                "id": "1440714988",
                "duration": 220800,
                "trackNumber": 4,
                "name": "Indestructible"
            },
            {
                "id": "1440714989",
                "duration": 214533,
                "trackNumber": 5,
                "name": "Time Machine"
            },
            {
                "id": "1440714991",
                "duration": 268387,
                "trackNumber": 6,
                "name": "Love Kills"
            },
            {
                "id": "1440714992",
                "duration": 259507,
                "trackNumber": 7,
                "name": "Hang With Me"
            },
            {
                "id": "1440714995",
                "duration": 227347,
                "trackNumber": 8,
                "name": "Call Your Girlfriend"
            },
            {
                "id": "1440714996",
                "duration": 311920,
                "trackNumber": 9,
                "name": "None of Dem (feat. Röyksopp)"
            },
            {
                "id": "1440715000",
                "duration": 266333,
                "trackNumber": 10,
                "name": "We Dance to the Beat"
            },
            {
                "id": "1440715122",
                "duration": 241080,
                "trackNumber": 11,
                "name": "U Should Know Better (feat. Snoop Dogg)",
                "contentRating": "explicit"
            },
            {
                "id": "1440715123",
                "duration": 217587,
                "trackNumber": 12,
                "name": "Dancehall Queen"
            },
            {
                "id": "1440715125",
                "duration": 220800,
                "trackNumber": 13,
                "name": "Get Myself Together"
            },
            {
                "id": "1440715126",
                "duration": 235587,
                "trackNumber": 14,
                "name": "In My Eyes"
            },
            {
                "id": "1440715127",
                "duration": 239560,
                "trackNumber": 15,
                "name": "Stars 4-Ever"
            },
            {
                "id": "1440715130",
                "duration": 254373,
                "trackNumber": 16,
                "name": "Dancehall Queen (Diplo and Stenchman Remix feat. Spoek Mathambo)"
            }
        ]
    }
}
""".data(using: .utf8)

      guard let albumData else {
        throw URLError(.cannotDecodeRawData)
      }

      let album = try JSONDecoder().decode(HundredBestAlbum.self, from: albumData)
      return album
    }
  }
}

