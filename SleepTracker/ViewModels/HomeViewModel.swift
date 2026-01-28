import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sleepStore: SleepStore
    
    // Connected to the UI controls
    @Published var targetBedtime: Date {
        didSet {
            sleepStore.schedule.targetBedtime = targetBedtime
            sleepStore.save()
        }
    }
    @Published var targetWakeUpTime: Date {
        didSet {
            sleepStore.schedule.targetWakeUpTime = targetWakeUpTime
            sleepStore.save()
        }
    }
    
    var lastNightMessage: String {
        sleepStore.lastNightQualityMessage
    }
    
    var lastNightDuration: String {
        sleepStore.sleepDurationLastNight
    }
    
    init(sleepStore: SleepStore) {
        self.sleepStore = sleepStore
        self.targetBedtime = sleepStore.schedule.targetBedtime
        self.targetWakeUpTime = sleepStore.schedule.targetWakeUpTime
    }
}
