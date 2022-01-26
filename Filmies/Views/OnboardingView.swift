//
//  OnboardingView.swift
//  Filmies
//
//  Created by bryan colin on 1/24/22.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - PROPERTIES
    
    @AppStorage(K.Settings.onboarding) var isOnboardingViewActive: Bool = true
    
    //MARK: - BODY
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    //MARK: - BODY
                    OnboardingDetailsView(image: "house", title: "Home", description: "View displaying movies and tv-shows.")
                    OnboardingDetailsView(image: "magnifyingglass.circle", title: "Search", description: "Search for movies or tv-shows.")
                    OnboardingDetailsView(image: "person", title: "Account", description: "Film screen times & finish watching films (movies or tv-shows).")
                    
                    Spacer()
                    
                    //MARK: - BUTTON
                    Button(action: {
                        isOnboardingViewActive = false
                    }) {
                        Text("Continue")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(10)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding(.vertical)
                } //: VSTACK
            } //: SCROLLVIEW
            .padding()
            .navigationTitle(Text("Featured"))
            .navigationBarTitleDisplayMode(.automatic)
            .background(Color(K.BrandColors.blue))
        } //: NAVIGATION VIEW
        .interactiveDismissDisabled()
    }
}

struct OnboardingDetailsView: View {
    
    //MARK: - PROPERTIES
    
    var image, title, description: String
    
    //MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: image)
                .padding(.vertical, 10)
                .foregroundColor(Color(K.BrandColors.pink))
            
            Text(title)
                .font(.title2)
                .fontWeight(.heavy)
            
            Text(description)
        } //: VSTACK
    }
}

//MARK: - PREVIEW

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
