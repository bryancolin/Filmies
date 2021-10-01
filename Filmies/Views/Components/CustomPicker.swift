//
//  CustomPicker.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct CustomPicker: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var modelData: ModelData
    @State var show: Bool = true
    
    var body: some View {
        HStack {
            if show {
                Text("Movie")
                    .foregroundColor(Color(K.BrandColors.pink))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .foregroundColor(Color.white)
                            .matchedGeometryEffect(id: "shape", in: animation)
                    )
                
                Text("TV")
                    .foregroundColor(Color.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)

            } else {
                Text("Movie")
                    .foregroundColor(Color.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                
                Text("TV")
                    .foregroundColor(Color(K.BrandColors.pink))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .foregroundColor(Color.white)
                            .matchedGeometryEffect(id: "shape", in: animation)
                    )
            }
        }
        .font(.system(size: 15, weight: .bold))
        .background(
            Capsule()
                .stroke(Color.white, lineWidth: 1)
        )
        .onTapGesture {
            withAnimation {
                show.toggle()
                modelData.selectedType = show ? .movie : .tvShow
            }
        }
        .onAppear {
            show = modelData.selectedType == .movie ? true : false
        }
    }
}
