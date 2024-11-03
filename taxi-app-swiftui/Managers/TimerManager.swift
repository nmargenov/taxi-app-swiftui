import Foundation
import Combine

class TimerManager: ObservableObject {
    private var timer: AnyCancellable?
    private var startTime: Date? // Make this optional
    private var backgroundTime: TimeInterval = 0 // Store the elapsed time when app goes to background
    
    @Published var elapsedSeconds: Int = 0 // Store the elapsed seconds
    
    // Start the stopwatch
    func start() {
        startTime = Date() // Record the start time
        elapsedSeconds = 0 // Reset elapsed seconds
        
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime() // Update elapsed time every second
            }
    }
    
    // Update elapsed time
    private func updateElapsedTime() {
        guard let startTime = startTime else { return }
        
        let elapsed = Date().timeIntervalSince(startTime) + backgroundTime // Include background time
        elapsedSeconds = Int(elapsed) // Update elapsed seconds
    }
    
    // Stop the stopwatch
    func stop() -> Int{
        timer?.cancel() // Stop the timer
        timer = nil
        
        // Print the total elapsed seconds
        return elapsedSeconds
    }
    
    // Call this method when the app goes to the background
    func appDidEnterBackground() {
        guard let startTime = startTime else { return }
        backgroundTime += Date().timeIntervalSince(startTime) // Calculate elapsed time
        self.startTime = nil // Clear start time
    }
    
    // Call this method when the app comes back to the foreground
    func appWillEnterForeground() {
        startTime = Date() // Reset start time
    }
}
