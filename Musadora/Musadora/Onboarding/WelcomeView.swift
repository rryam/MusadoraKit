//
//  WelcomeView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import MusicKit
import Observation
import SwiftUI

// NOTE:- MOST OF THE CODE HERE IS TAKEN FROM THE SAMPLE PROJECT BY APPLE.
// Using MusicKit to Integrate with Apple Music
//
// https://developer.apple.com/documentation/musickit/using_musickit_to_integrate_with_apple_music

struct WelcomeView: View {
    @Binding var musicAuthorizationStatus: MusicAuthorization.Status
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            gradient
            
            VStack(spacing: 0) {
                Spacer()
                
                Text("Musadora")
                    .foregroundColor(.primary)
                    .font(.largeTitle)
                    .bold()
                
                Text("Everything about your music.")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Spacer()
                
                if let secondaryExplanatoryText = self.secondaryExplanatoryText {
                    secondaryExplanatoryText
                        .foregroundColor(.primary)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding([.horizontal, .bottom])
                }
                
                if musicAuthorizationStatus == .notDetermined || musicAuthorizationStatus == .denied {
                    Button(action: handleButtonPressed) {
                        buttonText
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 14 / 255, green: 14 / 255, blue: 45 / 255))
                    .colorScheme(.dark)
                    .padding(.bottom)
                }
            }
            .colorScheme(.dark)
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: (222 / 255.0), green: (57 / 255.0), blue: (254 / 255.0)),
                Color(red: (90 / 255.0), green: (21 / 255.0), blue: (157 / 255.0)),
                Color(red: (45 / 255.0), green: (21 / 255.0), blue: (144 / 255.0))
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .flipsForRightToLeftLayoutDirection(false)
        .ignoresSafeArea()
    }
    
    private var secondaryExplanatoryText: Text? {
        var secondaryExplanatoryText: Text?
        switch musicAuthorizationStatus {
        case .denied:
            secondaryExplanatoryText = Text("Please grant Musadora access to \(Image(systemName: "applelogo")) Music in Settings.")
        default:
            break
        }
        return secondaryExplanatoryText
    }
    
    private var buttonText: Text {
        let buttonText: Text
        switch musicAuthorizationStatus {
        case .notDetermined:
            buttonText = Text("Continue")
        case .denied:
            buttonText = Text("Open Settings")
        default:
            fatalError("No button should be displayed for current authorization status: \(musicAuthorizationStatus).")
        }
        return buttonText
    }
    
    private func handleButtonPressed() {
        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                update(with: musicAuthorizationStatus)
            }
        case .denied:
            #if os(iOS)
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                openURL(settingsURL)
            }
            #endif
        default:
            fatalError("No button should be displayed for current authorization status: \(musicAuthorizationStatus).")
        }
    }
    
    @MainActor
    private func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
        withAnimation {
            self.musicAuthorizationStatus = musicAuthorizationStatus
        }
    }
    
    @Observable
    class PresentationCoordinator {
        static let shared = PresentationCoordinator()
        
        private init() {
            let authorizationStatus = MusicAuthorization.currentStatus
            
            debugPrint(MusicAuthorization.currentStatus.rawValue)
            
            musicAuthorizationStatus = authorizationStatus
            isWelcomeViewPresented = (authorizationStatus != .authorized)
        }
        
        var musicAuthorizationStatus: MusicAuthorization.Status {
            didSet {
                isWelcomeViewPresented = (musicAuthorizationStatus != .authorized)
            }
        }
        
        var isWelcomeViewPresented: Bool
    }
    
    fileprivate struct SheetPresentationModifier: ViewModifier {
        @State private var presentationCoordinator = PresentationCoordinator.shared

        func body(content: Content) -> some View {
            content
                #if os(iOS)
                .fullScreenCover(isPresented: $presentationCoordinator.isWelcomeViewPresented) {
                    WelcomeView(musicAuthorizationStatus: $presentationCoordinator.musicAuthorizationStatus)
                }
                #else
                .sheet(isPresented: $presentationCoordinator.isWelcomeViewPresented) {
                    WelcomeView(musicAuthorizationStatus: $presentationCoordinator.musicAuthorizationStatus)
                }
                #endif
        }
    }
}

extension View {
    func welcomeSheet() -> some View {
        modifier(WelcomeView.SheetPresentationModifier())
    }
}
