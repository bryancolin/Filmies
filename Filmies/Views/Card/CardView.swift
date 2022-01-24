//
//  CardView.swift
//  Filmies
//
//  Created by bryan colin on 7/13/21.
//

import SwiftUI

struct CardView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var category: String
    
    @State var scrolled = 0
    @State var offsets: [CGFloat] = Array(repeating: 0, count: 20)
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let translation = value.translation.width
                withAnimation {
                    if translation < 0 && scrolled < (modelData.films[category]?.count ?? 0) - 1{
                        offsets[scrolled] = translation
                    } else {
                        if scrolled > 0 {
                            offsets[scrolled - 1] = -(calculateWidth() + 60) + translation
                        }
                    }
                }
            }
            .onEnded { value in
                let translation = value.translation.width
                withAnimation {
                    if translation < 0 {
                        if -translation > 180 && scrolled < (modelData.films[category]?.count ?? 0) - 1 {
                            offsets[scrolled] = -(calculateWidth() + 60)
                            scrolled += 1
                        } else {
                            offsets[scrolled] = 0
                        }
                    } else {
                        if scrolled > 0 {
                            if translation > 180 {
                                offsets[scrolled - 1] = 0
                                scrolled -= 1
                            } else {
                                offsets[scrolled - 1] = -(calculateWidth() + 60)
                            }
                        }
                    }
                }
            }
    }
    
    //MARK: - BODY
    
    var body: some View {
        ZStack {
            if let films = modelData.films[category] {
                if !modelData.isLoading {
                    ForEach(films.enumerated().reversed(), id: \.offset) { index, film in
                        HStack {
                            ZStack(alignment: .bottomLeading) {
                                CardElementView(film: film, category: category, width: calculateWidth(), height: calculateHeight(with: index))
                            }
                            .offset(x: index - scrolled <= 2 ? CGFloat(index - scrolled) * 30 : 60)
                            
                            Spacer()
                        } //: HSTACK
                        .contentShape(Rectangle())
                        .offset(x: offsets[index])
                        .gesture(drag) //: GESTURE
                    } //: LOOP
                } else {
                    Color.white.opacity(0.2)
                }
            }
        } //: ZSTACK
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .cornerRadius(15)
        .padding()
        .redacted(reason: modelData.isLoading ? .placeholder : [])
        .overlay(alignment: .topTrailing) {
            Button(action: {
                scrolled = 0
                offsets = Array(repeating: 0, count: 20)
            }) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            .padding()
            .opacity(scrolled > 4 ? 1 : 0)
            .offset(y: -55)
        }
    }
    
    //MARK: - FUNCTIONS
    
    private func calculateWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 50) - (2 * 30)
    }
    
    private func calculateHeight(with index: Int) -> CGFloat {
        return (UIScreen.main.bounds.height / 1.8) - CGFloat(index - scrolled) * 50
    }
}

//MARK: - PREVIEW

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(category: "movie/now_playing")
            .environmentObject(ModelData())
    }
}



