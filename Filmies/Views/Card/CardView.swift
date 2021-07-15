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
    @ObservedObject var modelData: ModelData
    
    @State var scrolled = 0
    @State var offsets: [CGFloat] = Array(repeating: 0, count: 20)
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        
        let width = screen - (2 * 30)
        return width
    }
    
    func getArrayIndexed() -> [EnumeratedSequence<[Movie]>.Element] {
        return modelData.movies[category]?.enumerated().reversed().map { $0 } ?? [Movie]().enumerated().map { $0 }
    }
    
    var body: some View {
        ZStack {
            ForEach(getArrayIndexed(), id: \.element) { index, movie in
                HStack {
                    ZStack(alignment: .bottomLeading) {
                        WebImage(url: URL(string: movie.imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(index - scrolled) * 50)
                            .cornerRadius(15)
                            .overlay(
                                CardElementView(movie: movie), alignment: .bottomLeading
                            )
                    }
                    .offset(x: index - scrolled <= 2 ? CGFloat(index - scrolled) * 30 : 60)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .offset(x: offsets[index])
                .gesture(DragGesture().onChanged({ value in
                    let translation = value.translation.width
                    withAnimation {
                        if translation < 0 && index < (modelData.movies[category]?.count ?? 0) - 1{
                            offsets[index] = translation
//                            modelData.movies["now_playing"]?[index].offset = value.translation.width
                        } else {
                            if index > 0 {
                                offsets[index - 1] = -(calculateWidth() + 60) + translation
//                                modelData.movies["now_playing"]?[index - 1].offset = -(calculateWidth() + 60) + value.translation.width
                            }
                        }
                    }
                }).onEnded({ value in
                    let translation = value.translation.width
                    withAnimation {
                        if translation < 0 {
                            if -translation > 180 && index < (modelData.movies[category]?.count ?? 0) - 1 {
                                offsets[index] = -(calculateWidth() + 60)
//                                modelData.movies["now_playing"]?[index].offset = -(calculateWidth() + 60)
                                scrolled += 1
                            } else {
                                offsets[index] = 0
//                                modelData.movies["now_playing"]?[index].offset = 0
                            }
                        } else {
                            if index > 0 {
                                if translation > 180 {
                                    offsets[index - 1] = 0
//                                    modelData.movies["now_playing"]?[index - 1].offset = 0
                                    scrolled -= 1
                                } else {
                                    offsets[index - 1] = -(calculateWidth() + 60)
//                                    modelData.movies["now_playing"]?[index - 1].offset = -(calculateWidth() + 60)
                                }
                            }
                        }
                    }
                })
                )
            }
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .padding(.horizontal)
        .padding(.vertical, 20)
    }
}



