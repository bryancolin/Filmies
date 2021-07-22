//
//  CardView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    @Binding var category: String
    @EnvironmentObject var modelData: ModelData
    
    @State var scrolled = 0
    @State var offsets: [CGFloat] = Array(repeating: 0, count: 20)
    
    @State var flipped: Bool = false
    @State var flip: Bool = false
    
    var body: some View {
        ZStack {
            if let movies = modelData.movies[category] {
                if modelData.isLoading == false {
                    ForEach(movies.enumerated().reversed(), id: \.offset) { index, movie in
                        HStack {
                            ZStack(alignment: .bottomLeading) {
                                CardElementView(movie: movie, category: category, width: calculateWidth(), height: calculateHeight(with: index))
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
                                        if translation < 0 && index < (modelData.movies[category]?.count ?? 0) - 1{
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
                                            if -translation > 180 && index < (modelData.movies[category]?.count ?? 0) - 1 {
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
                    Color.white.opacity(0.5)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 20)
        .redacted(reason: modelData.isLoading ? .placeholder : [])
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        
        let width = screen - (2 * 30)
        return width
    }
    
    func calculateHeight(with index: Int) -> CGFloat {
        let screen = UIScreen.main.bounds.height / 1.8
        
        let height = screen - CGFloat(index - scrolled) * 50
        return height
    }
}



