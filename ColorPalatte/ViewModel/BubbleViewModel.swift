import SwiftUI
import Foundation

/// ViewModel to track selected keywords
class BubbleViewModel: ObservableObject {
    @Published var selectedKeywords: [String] = []

    /// Add/remove a keyword
    func toggle(_ keyword: String) {
        if let idx = selectedKeywords.firstIndex(of: keyword) {
            selectedKeywords.remove(at: idx)
        } else {
            selectedKeywords.append(keyword)
        }
        print("Selected keywords:", selectedKeywords)
    }
    
    /// Clear all selected keywords
    func clear() {
        selectedKeywords.removeAll()
        print("Selected keywords cleared")
    }
}
