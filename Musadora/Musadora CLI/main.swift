//
//  main.swift
//  Musadora CLI
//
//  Created by Rudrank Riyam on 11/14/25.
//

import Foundation
import MusadoraKit

@preconcurrency import MusicKit

print("Musadora CLI - Token Information")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

let status = await MusicAuthorization.request()
guard status == .authorized else {
  fputs("ERROR: Music authorization not granted\n", stderr)
  exit(1)
}

print("Authorization: OK\n")

do {
  let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)
  print("Developer Token:")
  print(developerToken)
  print("")

  let userToken = try await MusicDataRequest.tokenProvider.userToken(for: developerToken, options: .ignoreCache)
  print("User Token:")
  print(userToken)
  print("")
} catch {
  fputs("ERROR getting tokens: \(error)\n", stderr)
  exit(1)
}

