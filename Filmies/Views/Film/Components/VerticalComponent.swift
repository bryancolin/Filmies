//
//  VerticalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct VerticalComponent: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var title: String
    var urls: [String]
    var details: [String]
    var subDetails: [String]?
    
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .fontWeight(.semibold)
            
            CustomDivider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(0..<5) { index in
                        if index < details.count {
                            Button(action: {
                                isPresented.toggle()
                            }) {
                                VStack(alignment: .leading) {
                                    CustomImage(urlString: urls[index], placeholder: details[index])
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(details[index])
                                            .font(.caption)
                                        
                                        if let subDetails = subDetails {
                                            Text(subDetails[index])
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
                                PeopleView()
                                    .environmentObject(modelData)
                                    .animation(.default)
                            }
                        }
                    }
                }
            }
        }
    }
}
