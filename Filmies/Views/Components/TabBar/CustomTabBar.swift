//
//  CustomTabBar.swift
//  Filmies
//
//  Created by bryan colin on 7/21/21.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) {
                TabBarButton(image: $0, selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
        }
        .padding(0)
        .background(
            Color.white
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20),
            alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case .house:
                return tabPoints[0]
            case .search:
                return tabPoints[1]
            default:
                return tabPoints[2]
            }
        }
    }
}
