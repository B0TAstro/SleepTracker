import SwiftUI

struct TrackerView: View {
    @ObservedObject var viewModel: TrackerViewModel
    
    // Gradients
    let activeGradient = LinearGradient(colors: [Color.purple, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    let inactiveGradient = LinearGradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Sleep Trek")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.top, 40)
            
            // Central Status Indicator
            ZStack {
                Circle()
                    .stroke(viewModel.isTracking ? Color.purple.opacity(0.5) : Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 250, height: 250)
                    .shadow(color: viewModel.isTracking ? Color.purple : .clear, radius: 20)
                
                VStack {
                    Image(systemName: viewModel.isTracking ? "moon.stars.fill" : "sun.max.fill")
                        .font(.system(size: 60))
                        .foregroundColor(viewModel.isTracking ? .purple : .orange)
                    
                    Text(viewModel.isTracking ? "Sleeping..." : "Awake")
                        .font(.title2)
                        .bold()
                        .padding(.top, 10)
                    
                    if let start = viewModel.startTime {
                        Text("Since \(start.formatted(date: .omitted, time: .shortened))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            
            // Device Monitoring List
            VStack(alignment: .leading, spacing: 15) {
                Text("Active Devices")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.monitoredDevices, id: \.self) { device in
                            DeviceCard(device: device, status: viewModel.deviceStatus[device] ?? "Unknown")
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
            
            // Big Action Button
            Button(action: {
                withAnimation(.spring()) {
                    if viewModel.isTracking {
                        viewModel.wakeUp()
                    } else {
                        viewModel.startSleep()
                    }
                }
                #if canImport(UIKit)
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                #endif
            }) {
                Text(viewModel.isTracking ? "WAKE UP" : "GO TO SLEEP")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(viewModel.isTracking ? Color.orange : Color.purple)
                    .cornerRadius(20)
                    .shadow(color: viewModel.isTracking ? Color.orange.opacity(0.5) : Color.purple.opacity(0.5), radius: 10)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
    }
}

struct DeviceCard: View {
    let device: DeviceType
    let status: String
    
    var iconName: String {
        switch device {
        case .iphone: return "iphone"
        case .mac: return "laptopcomputer"
        case .watch: return "applewatch"
        case .vision: return "visionpro"
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.white)
            Text(device.rawValue)
                .font(.caption)
                .bold()
            Text(status)
                .font(.caption2)
                .foregroundColor(status == "Active" ? .green : .gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.white.opacity(0.08))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}
