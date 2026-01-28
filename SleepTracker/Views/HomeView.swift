import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    // Gradients
    let cardGradient = LinearGradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                // Header
                Text("Good Evening, Player One")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(colors: [.white, .gray], startPoint: .leading, endPoint: .trailing))
                    .padding(.top, 20)
                
                // Night Summary Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Last Night")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.lastNightDuration)
                                .font(.system(size: 48, weight: .heavy, design: .monospaced))
                                .foregroundColor(.cyan)
                            Text("Time Asleep")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Circle()
                            .stroke(Color.cyan.opacity(0.3), lineWidth: 8)
                            .frame(width: 60, height: 60)
                            .overlay(Text("85%").font(.caption).bold())
                    }
                    
                    Text(viewModel.lastNightMessage)
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 5)
                }
                .padding(20)
                .background(cardGradient)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(color: Color.black.opacity(0.2), radius: 10)
                
                // Goal Settings
                Text("Sleep Goals")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 0) {
                    // Bedtime Picker
                    HStack {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(.purple)
                        Text("Bedtime")
                            .bold()
                        Spacer()
                        DatePicker("", selection: $viewModel.targetBedtime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .colorScheme(.dark)
                    }
                    .padding()
                    
                    Divider().background(Color.white.opacity(0.1))
                    
                    // Wake Up Picker
                    HStack {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                        Text("Wake Up")
                            .bold()
                        Spacer()
                        DatePicker("", selection: $viewModel.targetWakeUpTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .colorScheme(.dark)
                    }
                    .padding()
                }
                .background(cardGradient)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
