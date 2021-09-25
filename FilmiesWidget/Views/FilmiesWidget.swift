//
//  FilmiesWidget.swift
//  FilmiesWidget
//
//  Created by bryan colin on 9/23/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> Model {
        Model(date: Date(), data: Detail.placeholderData)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Model) -> ()) {
        let entry = Model(date: Date(), data: Detail.placeholderData)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let currentDate = Date()
            let nextUpdate = Calendar.current.date(byAdding: .hour, value: 24, to: currentDate)
            
            let data = await Model(date: currentDate, data: getData())
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            
            completion(timeline)
        }
    }
}

func getData() async -> [Detail] {
    let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
    
    do {
        let result = try await URLSession.shared.request(url: URL(string: url), expecting: JSONData.self)
        if let results = result.all {
            return results
        }
    } catch {
        print(error.localizedDescription)
    }
    
    return Detail.placeholderData
}

struct Model: TimelineEntry {
    let date: Date
    let data: [Detail]
}

struct FilmiesWidgetEntryView : View {
    var entry: Model
    
    var body: some View {
        WidgetView(entry: entry)
    }
}

@main
struct FilmiesWidget: Widget {
    let kind: String = "FilmiesWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            FilmiesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Filmies Launcher")
        .description("Display Trending Movies.")
    }
}

struct FilmiesWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Detail.placeholderData))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Detail.placeholderData))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Detail.placeholderData))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
