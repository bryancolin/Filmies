//
//  ChartTab.swift
//  Filmies
//
//  Created by bryan colin on 8/8/21.
//

import SwiftUI

struct ChartTab: View {
    
    //MARK: - PROPERTIES
    
    var title: String
    @Binding var selectedIndex: Int
    
    //MARK: - BODY
    
    var body: some View {
        HStack {
            IconButton(title: "chevron.left") {
                withAnimation {
                    selectedIndex -= 1
                }
            }
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            IconButton(title: "chevron.right") {
                withAnimation {
                    selectedIndex += 1
                }
            }
            .opacity(selectedIndex == 0 ? 0 : 1)
            .disabled(selectedIndex == 0 ? true : false)
            
        } //: HSTACK
        .foregroundColor(.white)
        .padding()
    }
}

//MARK: - PREVIEW

struct ChartTab_Previews: PreviewProvider {
    static var previews: some View {
        ChartTab(title: "Screen Time", selectedIndex: .constant(0))
    }
}
