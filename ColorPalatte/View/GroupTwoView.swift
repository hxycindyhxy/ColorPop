// GroupTwoView.swift
import SwiftUI

/// Second bubble group view: tapping toggles selection, but stops at 3 keywords
struct GroupTwoView: View {
    @EnvironmentObject var viewModel: BubbleViewModel

    private let bubbles: [Bubble] = [
        Bubble(id: 0, size: 100, offset: CGSize(width: -80,  height: -100), label: "Luxurious"),
        Bubble(id: 1, size: 120, offset: CGSize(width:  60,  height: -130), label: "Girly"),
        Bubble(id: 2, size: 100,  offset: CGSize(width:  140, height:  -30), label: "Elegant"),
        Bubble(id: 3, size: 130, offset: CGSize(width: -120, height:   20), label: "Night"),
        Bubble(id: 4, size: 120, offset: CGSize(width:   20,  height:   80), label: "Minimal"),
    ]

    var body: some View {
        ZStack {
            ForEach(bubbles) { bubble in
                let isSelected = viewModel.selectedKeywords.contains(bubble.label)
                // prevent selecting more once 3 are chosen
                let cannotSelectMore = !isSelected && viewModel.selectedKeywords.count >= 3

                Button {
                    viewModel.toggle(bubble.label)
                } label: {
                    Circle()
                        .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:6)
                        .frame(width: bubble.size, height: bubble.size)
                        .foregroundStyle(
                            isSelected
                                ? Color(red: 139/255, green: 141/255, blue: 174/255)  // selected
                                : Color(red: 215/255, green: 216/255, blue: 234/255)  // original
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
        .frame(width: 400, height: 250)
        .padding()
    }
}

struct GroupTwoView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTwoView()
            .environmentObject(BubbleViewModel())
    }
}
