//
//  CustomPicker.swift
//  Filmies
//
//  Created by bryan colin on 8/5/21.
//

import SwiftUI

struct CustomPicker: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var width: CGFloat
    
    init(width: CGFloat) {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(K.BrandColors.pink))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        self.width = width
    }
    
    var body: some View {
        Picker(selection: $modelData.selectedType, label: Text("")) {
            ForEach(FilmType.allCases, id: \.self) { type in
                Text(type.rawValue.first?.uppercased() ?? "").tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: width)
    }
}
