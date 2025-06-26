// GroupOneView.swift
import SwiftUI

/// First bubble group view: tapping toggles selection, but stops at 3 keywords
struct GroupOneView: View {
    @EnvironmentObject var viewModel: BubbleViewModel

    private let bubbles: [Bubble] = [
        Bubble(id: 0, size: 100,  offset: CGSize(width: -120, height: -80), label: "Fun"),
        Bubble(id: 1, size: 130,  offset: CGSize(width:  100, height:  -80), label: "Relaxing"),
        Bubble(id: 2, size: 110,  offset: CGSize(width:  120, height:   60), label: "Blue"),
        Bubble(id: 3, size: 120, offset: CGSize(width: -100, height:  90), label: "Bubbly"),
        Bubble(id: 4, size: 120, offset: CGSize(width:    0, height:    0), label: "Calm")
    ]

    var body: some View {
        ZStack {
            ForEach(bubbles) { bubble in
                let isSelected = viewModel.selectedKeywords.contains(bubble.label)
                // disable if not selected AND already have 3
                let cannotSelectMore = !isSelected && viewModel.selectedKeywords.count >= 3

                Button {
                    viewModel.toggle(bubble.label)
                } label: {
                    Circle()
                        .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:6)
                        .frame(width: bubble.size, height: bubble.size)
                        .foregroundStyle(
                            isSelected
                                ? Color(red: 211/255, green: 167/255, blue: 188/255) // selected: D3A7BC
                                : Color(red: 227/255, green: 207/255, blue: 217/255) // original
                        )
                        .overlay(
                            Text(bubble.label)
                                .font(.caption)
                                .foregroundColor(.black)
                        )
                        // optionally dim unselectable bubbles
                        .opacity(cannotSelectMore ? 0.5 : 1.0)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(cannotSelectMore)
                .offset(bubble.offset)
            }
        }
        .frame(width: 400, height: 260)
        .padding()
    }
}

struct GroupOneView_Previews: PreviewProvider {
    static var previews: some View {
        GroupOneView()
            .environmentObject(BubbleViewModel())
    }
}
