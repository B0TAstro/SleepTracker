import SwiftUI

struct MainTabView: View {
    @StateObject private var sleepStore = SleepStore()
    
    // Custom Colors
    let darkBackground = Color(red: 0.05, green: 0.05, blue: 0.1) // Deep Midnight Blue
    let neonCyan = Color(red: 0.0, green: 1.0, blue: 0.9)
    let neonPurple = Color(red: 0.8, green: 0.0, blue: 1.0)
    
    // init() {
    //    UITabBar.appearance().isHidden = true
    // }
    
    @State private var selection = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Background
            LinearGradient(gradient: Gradient(colors: [darkBackground, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Content
            TabView(selection: $selection) {
                HomeView(viewModel: HomeViewModel(sleepStore: sleepStore))
                    .tag(0)
                
                TrackerView(viewModel: TrackerViewModel(sleepStore: sleepStore))
                    .tag(1)
                
                StatsView(viewModel: StatsViewModel(sleepStore: sleepStore))
                    .tag(2)
            }
            // Add padding to avoid content being hidden by custom tab bar
            .padding(.bottom, 80) 
            
            // Custom Tab Bar
            HStack {
                ForEach(0..<3) { index in
                    Spacer()
                    Button(action: {
                        withAnimation {
                            selection = index
                        }
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: iconName(for: index))
                                .font(.system(size: 24, weight: .bold))
                            
                            if selection == index {
                                Circle()
                                    .fill(neonCyan)
                                    .frame(width: 5, height: 5)
                            }
                        }
                        .foregroundColor(selection == index ? neonCyan : .gray)
                        .scaleEffect(selection == index ? 1.1 : 1.0)
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 20)
            .background(.thinMaterial)
//            .background(
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(Color.white.opacity(0.1))
//                    .blur(radius: 3)
//            )
            .clipShape(Capsule())
            .shadow(color: neonPurple.opacity(0.3), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
        }
        .preferredColorScheme(.dark)
    }
    
    func iconName(for index: Int) -> String {
        switch index {
        case 0: return "moon.stars.fill"
        case 1: return "bed.double.fill" // or "stopwatch.fill"
        case 2: return "chart.bar.xaxis"
        default: return ""
        }
    }
}
