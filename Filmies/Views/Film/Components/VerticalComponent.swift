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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .fontWeight(.semibold)
            
            CustomDivider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<5) { index in
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
                isPresented.toggle()
            }
        }) {
            VStack(alignment: .leading) {
                CustomImage(urlString: url, placeholder: detail)
                    .frame(width: 75, height: 75)
                    .cornerRadius(50)
                
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
                .frame(width: 75)
            }
            .padding(.vertical, 10)
        }
        .fullScreenCover(isPresented: $isPresented) {
            PeopleView(id: id)
                .environmentObject(modelData)
                .animation(.default)
        }
    }
}
