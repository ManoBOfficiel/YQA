import SwiftUI
import AVKit
import AVFoundation
import WebKit

// Palette personnalisée
enum AppColors {
    static let violet = Color(red: 108/255, green: 49/255, blue: 168/255)
    static let jaune = Color(red: 255/255, green: 215/255, blue: 0/255)
}

struct YoutubeWebView: UIViewRepresentable {
    let videoID: String
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let embedURLString = "https://www.youtube.com/embed/\(videoID)?autoplay=1&modestbranding=1&playsinline=1"
        if let url = URL(string: embedURLString) {
            webView.scrollView.isScrollEnabled = false
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct SplashView: View {
    // Indique si on doit afficher l'écran principal
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 24) {
                // Logo ou titre
                Text("Y’a que la vérité qui compte")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(LinearGradient(colors: [AppColors.jaune, AppColors.violet], startPoint: .leading, endPoint: .trailing))
                Text("Le générique")
                    .foregroundStyle(.secondary)
                // Aperçu vidéo
                YoutubeWebView(videoID: "Zlyw21tBbRo")
                    .frame(height: 220)
                    .cornerRadius(24)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .onAppear {
            // Après 20 secondes, passer à l'écran principal
            DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                isActive = false
            }
        }
    }
}

struct GeneriqueLoopView: View {
    @State private var applauseCount = 0

    var body: some View {
        VStack(spacing: 32) {
            Text("🎬 Le générique en public")
                .font(.title.weight(.bold))
                .foregroundStyle(LinearGradient(colors: [AppColors.jaune, AppColors.violet], startPoint: .leading, endPoint: .trailing))
            YoutubeWebView(videoID: "Zlyw21tBbRo")
                .frame(height: 220)
                .cornerRadius(24)
                .shadow(radius: 10)
            HStack(spacing: 24) {
                Button(action: {
                    applauseCount += 1
                }) {
                    Label("Applaudir", systemImage: "hands.clap.fill")
                        .font(.headline)
                        .padding()
                        .background(AppColors.jaune.opacity(0.7))
                        .foregroundStyle(.black)
                        .cornerRadius(16)
                }
                Text("👏\(applauseCount)")
                    .font(.title2)
            }
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var showSplash = true
    var body: some View {
        if showSplash {
            SplashView(isActive: $showSplash)
        } else {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 32) {
                        // Branding principal
                        VStack(spacing: 8) {
                            Text("Y’a que la vérité qui compte")
                                .font(.largeTitle.weight(.bold))
                                .foregroundStyle(LinearGradient(colors: [AppColors.jaune, AppColors.violet], startPoint: .leading, endPoint: .trailing))
                                .shadow(color: AppColors.jaune.opacity(0.7), radius: 6, x: 0, y: 0)
                                .shadow(color: AppColors.violet.opacity(0.6), radius: 12, x: 0, y: 0)
                            Text("L’émission qui fait vibrer la vérité !")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(AppColors.jaune.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        
                        NavigationLink(destination: GeneriqueLoopView()) {
                            Label("Lancer le générique en public", systemImage: "music.mic")
                                .font(.headline)
                                .padding()
                                .background(AppColors.jaune)
                                .foregroundStyle(.black)
                                .cornerRadius(18)
                        }

                        // Navigation vers les différentes fonctionnalités
                        VStack(spacing: 24) {
                            FeatureLink(title: "Présentation des animateurs", subtitle: "Découvrez Pascal, Laurent, Rebecca & Daphné", color: AppColors.violet, systemImage: "person.2.fill")
                            FeatureLink(title: "Vidéos en streaming", subtitle: "Regardez les moments forts et contenus exclusifs", color: AppColors.jaune, systemImage: "play.rectangle.fill")
                            FeatureLink(title: "Interaction avec le public", subtitle: "Commentez et échangez en temps réel", color: AppColors.violet, systemImage: "bubble.left.and.bubble.right.fill")
                            FeatureLink(title: "Formulaires & emails intégrés", subtitle: "Envoyez vos histoires, recevez des nouvelles", color: AppColors.jaune, systemImage: "envelope.fill")
                            FeatureLink(title: "Rencontres avec les fans", subtitle: "Suivez les déplacements et événements", color: AppColors.violet, systemImage: "map.fill")
                            FeatureLink(title: "Messages vidéos en direct", subtitle: "Partagez et consultez des vidéos live", color: AppColors.jaune, systemImage: "mic.fill")
                            FeatureLink(title: "Événements hebdomadaires", subtitle: "Rendez-vous vidéo tous les jeudis", color: AppColors.violet, systemImage: "calendar")
                            FeatureLink(title: "Plateforme d’interaction du public", subtitle: "Discutez entre fans, partagez vos émotions", color: AppColors.jaune, systemImage: "hands.clap.fill")
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Accueil")
                .background(
                    ZStack {
                        // Dégradé principal
                        LinearGradient(
                            gradient: Gradient(colors: [AppColors.violet, AppColors.jaune, .white]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                        // Cercles décoratifs flous
                        Circle()
                            .fill(AppColors.jaune.opacity(0.30))
                            .frame(width: 320, height: 320)
                            .blur(radius: 60)
                            .offset(x: -120, y: -160)
                        Circle()
                            .fill(AppColors.violet.opacity(0.28))
                            .frame(width: 240, height: 240)
                            .blur(radius: 50)
                            .offset(x: 140, y: 120)
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 200, height: 200)
                            .blur(radius: 54)
                            .offset(x: 40, y: 300)
                    }
                )
            }
        }
    }
}

struct FeatureLink: View {
    let title: String
    let subtitle: String
    let color: Color
    let systemImage: String

    var body: some View {
        NavigationLink(destination: FeatureDetailView(title: title)) {
            HStack(spacing: 16) {
                Image(systemName: systemImage)
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
                    .padding()
                    .background(color.gradient)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(color.opacity(0.07))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct FeatureDetailView: View {
    let title: String
    var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .font(.largeTitle.weight(.bold))
                .padding()
            Text("Cette fonctionnalité sera prochainement implémentée. Restez connectés pour découvrir toutes les nouveautés !")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}

#Preview {
    ContentView()
}
