//
//  CustomTabBar.swift
//  Filmies
//
//  Created by bryan colin on 7/21/21.
//

import SwiftUI

struct CustomTabBar: View {
    
    //MARK: - PROPERTIES
    
    @Binding var selectedTab: Tab
    
    @State var tabPoints: [CGFloat] = Array(repeating: 0, count: Tab.allCases.count)
    
    //MARK: - BODY
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(Tab.allCases.enumerated()), id: \ .element) { index, tab in
                TabBarButton(index: index, image: tab, selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
        } //: HSTACK
        .padding(0)
        .background(
            Color.white
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(alignment: .bottomLeading) {
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: getCurvePoint())
        }
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    //MARK: - FUNCTIONS
    
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

//MARK: - PREVIEW

struct CustomTabBar_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(Tab.house), tabPoints: [CGFloat.zero])
    }
}

