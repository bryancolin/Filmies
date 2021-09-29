//
//  VerticalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct VerticalComponent: View {
    
    var title: String
    var urls: [String]
    var details: [String]
    var subDetails: [String]?
    var id: [Int]
    
    @State var showDetail = true
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title).fontWeight(.semibold)
                Spacer()
                IconButton(title: "chevron.down") {
                    withAnimation {
                        showDetail.toggle()
                    }
                }
                .font(.caption2)
                .rotationEffect(.degrees(showDetail ? 180 : 0))
            }
            
            CustomDivider()
            
            if showDetail {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                    ForEach(0..<details.count) { index in
                        if index < details.count {
                            VerticalComponentDetails(url: urls[index], detail: details[index], subDetail: subDetails?[index], id: id[index])
                        }
                    }
                }
            }
        }
    }
}

struct VerticalComponentDetails: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var url: String
    var detail: String
    var subDetail: String?
    var id: Int
    
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            if !url.isEmpty {
                withAnimation {
                    isPresented.toggle()
                }
            }
        }) {
            GeometryReader { geometry in
                let height = geometry.size.height / 2
                
                VStack(alignment: .leading) {
                    CustomImage(urlString: url, placeholder: detail)
                        .frame(width: height, height: height)
                        .cornerRadius(height / 2)
                    
                    VStack(alignment: .leading) {
                        Text(detail)
                            .font(.caption)
                        
                        if let subDetail = subDetail {
                            Text(subDetail)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                    }
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                }
                .padding(.vertical, 10)
            }
            .frame(height: 150)
        }
        .fullScreenCover(isPresented: $isPresented) {
            PeopleView(id: id)
                .environmentObject(modelData)
        }
    }
}
