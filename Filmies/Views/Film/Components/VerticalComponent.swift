//
//  VerticalComponent.swift
//  Filmies
//
//  Created by bryan colin on 8/2/21.
//

import SwiftUI

struct VerticalComponent: View {
    
    //MARK: - PROPERTIES
    
    var title: String
    var urlsPath: [String]
    var details: [String]
    var subDetails: [String]?
    var id: [Int]
    
    @State var showDetail = true
    
    //MARK: - BODY
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    showAnimation()
                }) {
                    Text(title).fontWeight(.semibold)
                    Spacer()
                    IconButton(title: "chevron.down") {
                        showAnimation()
                    }
                    .font(.caption2)
                    .rotationEffect(.degrees(showDetail ? 180 : 0))
                }
            } //: HSTACK
            
            CustomDivider()
            
            if showDetail {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                    ForEach(0..<details.count) { index in
                        if index < details.count {
                            VerticalComponentDetails(urlPath: urlsPath[index], detail: details[index], subDetail: subDetails?[index], id: id[index])
                        }
                    } //: LOOP
                } //: GRID
            }
        } //: VSTACK
    }
    
    //MARK: - FUNCTION
    
    func showAnimation() {
        withAnimation {
            showDetail.toggle()
        }
    }
}

struct VerticalComponentDetails: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject var modelData: ModelData
    
    var urlPath: String
    var detail: String
    var subDetail: String?
    var id: Int
    
    @State private var isPresented = false
    
    //MARK: - BODY
    
    var body: some View {
        Button(action: {
            if !urlPath.isEmpty {
                withAnimation {
                    isPresented.toggle()
                }
            }
        }) {
            GeometryReader { geometry in
                let height = geometry.size.height / 2
                
                VStack(alignment: .leading) {
                    CustomImage(urlPath: urlPath, placeholder: detail)
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
                    } //: VSTACK
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                } //: VSTACK
                .padding(.vertical, 10)
            }
            .frame(height: 150)
        } //: BUTTON
        .fullScreenCover(isPresented: $isPresented) {
            PeopleView(id: id, name: detail, urlPath: urlPath)
                .environmentObject(modelData)
        }
    }
}

//MARK: - PREVIEW

struct VerticalComponent_Previews: PreviewProvider {
    static var previews: some View {
        VerticalComponent(title: "Bryan Colin", urlsPath: [""], details: [""], id: [0])
            .environmentObject(ModelData())
    }
}
