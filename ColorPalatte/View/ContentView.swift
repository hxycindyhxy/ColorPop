// ContentView.swift
import SwiftUI
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BubbleViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 30) {
                        Color.clear
                            .frame(height: 20)
                        
                        Text("Choose three keywords:")
                            .font(.title)

                        GroupOneView()
                        GroupTwoView()
                        GroupThreeView()
                    }
                    .padding(.bottom, 100)  // leave space for button
                    .padding(.horizontal)
                }

                // Compute enabled state
                let isEnabled = viewModel.selectedKeywords.count == 3
                
                // pick mood based on keywords
                  let destinationMood: Mood = {
                      if viewModel.selectedKeywords.contains("Luxurious") {
                          return .mood1
                      } else if viewModel.selectedKeywords.contains("Fun") {
                          return .mood2
                      } else {
                          return .mood3
                      }
                  }()

                // Floating Create link
                NavigationLink(
                      destination: ColorPalette(mood: destinationMood)
                          .environmentObject(viewModel)
                  ) {
                    Text("Create")
                         .font(.headline)
                         .padding(.horizontal, 24)
                         .padding(.vertical, 12)
                         .background(
                             isEnabled
                                 ? Color(red: 113/255, green:  74/255, blue:  68/255)
                             : Color(white: 0.8)
                         )
                         .foregroundColor(.white)                                              // always white text
                         .cornerRadius(10)
                         .shadow(radius: 4)
                }
                .disabled(!isEnabled)    // make non-clickable when not exactly 3
                .padding(.bottom, 20)
            }

        }
        .environmentObject(viewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
