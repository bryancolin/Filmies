//
//  CardView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var category: String
    
    @State var scrolled = 0
    @State var offsets: [CGFloat] = Array(repeating: 0, count: 20)
    
    var body: some View {
        ZStack {
            if let films = modelData.films[category] {
                if modelData.isLoading == false {
                    ForEach(films.enumerated().reversed(), id: \.offset) { index, film in
                        HStack {
                            ZStack(alignment: .bottomLeading) {
                                CardElementView(film: film, category: category, width: calculateWidth(), height: calculateHeight(with: index))
                            }
                            .offset(x: index - scrolled <= 2 ? CGFloat(index - scrolled) * 30 : 60)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .offset(x: offsets[index])
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let translation = value.translation.width
                                    withAnimation {
                                        if translation < 0 && index < (modelData.films[category]?.count ?? 0) - 1{
                                            offsets[index] = translation
                                        } else {
                                            if index > 0 {
                                                offsets[index - 1] = -(calculateWidth() + 60) + translation
                                            }
                                        }
                                    }
                                }
                                .onEnded { value in
                                    let translation = value.translation.width
                                    withAnimation {
                                        if translation < 0 {
                                            if -translation > 180 && index < (modelData.films[category]?.count ?? 0) - 1 {
                                                offsets[index] = -(calculateWidth() + 60)
                                                scrolled += 1
                                            } else {
                                                offsets[index] = 0
                                            }
                                        } else {
                                            if index > 0 {
                                                if translation > 180 {
                                                    offsets[index - 1] = 0
                                                    scrolled -= 1
                                                } else {
                                                    offsets[index - 1] = -(calculateWidth() + 60)
                                                }
                                            }
                                        }
                                    }
                                }
                        )
                    }
                } else {
                    Color.white.opacity(0.2)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .cornerRadius(15)
        .padding()
        .redacted(reason: modelData.isLoading ? .placeholder : [])
    }
    
    func calculateWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 50) - (2 * 30)
    }
    
    func calculateHeight(with index: Int) -> CGFloat {
        return (UIScreen.main.bounds.height / 1.8) - CGFloat(index - scrolled) * 50
    }
}



