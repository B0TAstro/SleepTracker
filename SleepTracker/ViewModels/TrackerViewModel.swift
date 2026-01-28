import Foundation

@MainActor
class TrackerViewModel: ObservableObject {
    @Published var sleepStore: SleepStore
    @Published var isTracking = false
    @Published var startTime: Date?
    
    var monitoredDevices: [DeviceType] = [.iphone, .mac, .watch]
    
    // This would ideally listen to cross-device status
    var deviceStatus: [DeviceType: String] = [
        .iphone: "Monitoring",
        .mac: "Active",
        .watch: "Charging"
    ]
    
    init(sleepStore: SleepStore) {
        self.sleepStore = sleepStore
    }
    
    func startSleep() {
        isTracking = true
        startTime = Date()
        // Simulate a notification or focus mode activation
    }
    
    func wakeUp() {
        guard let start = startTime else { return }
        isTracking = false
        let end = Date()
        
        // Add session to store
        sleepStore.addSession(bedTime: start, wakeTime: end)
        startTime = nil
    }
}
