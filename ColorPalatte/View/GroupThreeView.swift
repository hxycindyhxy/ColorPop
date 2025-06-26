// GroupThreeView.swift
import SwiftUI

/// Third bubble group view: tapping a bubble toggles its label in the ViewModel and stops at 3 selections
struct GroupThreeView: View {
    @EnvironmentObject var viewModel: BubbleViewModel

    private let bubbles: [Bubble] = [
        Bubble(id: 0, size: 120,  offset: CGSize(width: -120, height:  -40), label: "Branding"),
        Bubble(id: 1, size: 110, offset: CGSize(width:   80, height: -70), label: "Outfit"),
        Bubble(id: 2, size: 115, offset: CGSize(width:  140, height:   40), label: "Interior Design"),
        Bubble(id: 3, size: 100, offset: CGSize(width: -100, height:  140), label: "Website"),
        Bubble(id: 4, size: 130, offset: CGSize(width:   5, height:   60), label: "Architecture"),
        Bubble(id: 5, size:  95, offset: CGSize(width:   60, height:  160), label: "Calm")
    ]

    var body: some View {
        ZStack {
            ForEach(bubbles) { bubble in
                let isSelected = viewModel.selectedKeywords.contains(bubble.label)
                // disable if not already selected and 3 have been chosen
                let cannotSelectMore = !isSelected && viewModel.selectedKeywords.count >= 3

                Button {
                    viewModel.toggle(bubble.label)
                } label: {
                    Circle()
                        .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:6)
                        .frame(width: bubble.size, height: bubble.size)
                        .foregroundStyle(
                            isSelected
                                ? Color(red: 99/255,  green: 121/255, blue: 100/255)  // selected: #637964
                                : Color(red: 198/255, green: 211/255, blue: 199/255)  // original: #C6D3C7
                        )
                        .overlay(
                            Text(bubble.label)
                                .font(.caption)
                                .foregroundColor(.black)
                        )
                        .opacity(cannotSelectMore ? 0.5 : 1.0)  // dim if disabled
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(cannotSelectMore)
                .offset(bubble.offset)
            }
        }
        .frame(width: 400, height: 200)
        .padding()
    }
}

struct GroupThreeView_Previews: PreviewProvider {
    static var previews: some View {
        GroupThreeView()
            .environmentObject(BubbleViewModel())
    }
}
