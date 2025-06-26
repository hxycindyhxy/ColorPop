//
//  ColorPalatteView.swift
//  ColorPalatte
//
//  Created by Xinyi Hu on 26/6/2025.
//

//import SwiftUI
//
//struct ColorPalatteView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    ColorPalatteView()
//}

//
//  ColorPop.swift
//  Xcode Demo
//
//  Created by MACBOOK_PRO on 26/6/2025.
//

import SwiftUI

let colorPalettes: [[String]] = [
    //Luxurious, outfit, night
    ["#390517", "#A38560", "#16302B", "#03110D", "#E0E0E0"],
    ["#480903", "#637424", "#E50144", "#CE793A", "#864B12"],
    ["#29281E", "#857861", "#E7D4BB", "#48252F", "#101211"],
    ["#FDB52A", "#FF6C1F", "#FEBAED", "#AEA434", "#76B3D0"],
    
    //Fun, website, girly
    ["#F3A2BE", "#FFD3DD", "#F0F9F8", "#C6E6E3", "#81BFB7"],
    ["#C1D2D9", "#E0B0EA", "#4D5BC8", "#FD500C", "#FF89D3"],
    ["#fec5bb", "#fcd5ce", "#fae1dd", "#f8edeb", "#e8e8e4"],
    
    //else case
    ["#ddbea9", "#ffe8d6", "#b7b7a4", "#a5a58d", "#6b705c"],
    ["#a3a380", "#ffe8d6", "#efebce", "#d8a48f", "#bb8588"],
    ["#606c38", "#283618", "#fefae0", "#dda15e", "#bc6c25"],
]

enum Mood: Int {
    case mood1
    case mood2
    case mood3 // == else case
    
    var paletteIndices: [Int] {
        switch self {
        case .mood1:
            return [0, 1, 2]  // palette list for mood1
        case .mood2:
            return [3, 4, 5, 6]  // palette list for mood2
        case .mood3:
            return [7, 8]
        }
    }
}


struct ColorPalette: View {
    
    @StateObject private var viewModel = BubbleViewModel()
    @Environment(\.dismiss) private var dismiss
    
    let mood: Mood
        
        @State private var currentPalette: [String]
        
        init(mood: Mood) {
            self.mood = mood
            let firstPaletteIndex = mood.paletteIndices.first ?? 0
            _currentPalette = State(initialValue: colorPalettes[firstPaletteIndex])
        }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                ForEach(currentPalette, id: \.self) { hex in
                    ColorBox(hexCode: hex)
                }
            }
            .frame(minHeight: UIScreen.main.bounds.height)
        }
        .ignoresSafeArea()
        .refreshable {
            await refreshPalette()
        }
        .navigationBarBackButtonHidden(true)       // hide the default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.clear()              // clear selections
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left") // only the arrow
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
        }
        .onDisappear {
              // clear selections when you pop (swipe) back
              viewModel.clear()
          }
    }
    
    func refreshPalette() async {
            try? await Task.sleep(nanoseconds: 800_000_000)
            
            let availableIndices = mood.paletteIndices.filter { index in
                colorPalettes[index] != currentPalette
            }
            
            if let newIndex = availableIndices.randomElement() {
                currentPalette = colorPalettes[newIndex]
            }
        }
}


struct ColorBox: View {
    let hexCode: String
    
    @State private var isCopied = false
    
    var body: some View {
            ZStack {
                Color(hex: hexCode)
                Text(hexCode)
                    .foregroundColor(.white)
                    .font(.callout)
                    .bold()
                
                if isCopied {
                    Text("Copied!")
                        .padding(15)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .transition(.opacity)
                }
            }  .onTapGesture {
                UIPasteboard.general.string = hexCode
                isCopied = true
                print("Copied: \(hexCode)")
                
                //timer
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isCopied = false
                }
            }
        }
    }


struct MoodColorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorPalette(mood: .mood1)
            ColorPalette(mood: .mood2)
            ColorPalette(mood: .mood3)
        }
    }
}
