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
    
    let modelData = ModelData()
    let films = Film.getPlaceholderData()
    
    func placeholder(in context: Context) -> Model {
        Model(date: Date(), data: films)
    }
    
    func getSnapshot(for configuration: FilmiesConfigurationIntent, in context: Context, completion: @escaping (Model) -> ()) {
        let entry = Model(date: Date(), data: films)
        completion(entry)
    }
    
    func getTimeline(for configuration: FilmiesConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let config = configuration.ShowMovieOrTV == .movie ? K.Movie.daily : K.Tv.daily
            await modelData.fetchFilms(with: config)
            
            let currentDate = Date()
            let nextUpdate = Calendar.current.date(byAdding: .hour, value: 24, to: currentDate)
            
            let data = Model(date: currentDate, data: modelData.films[config] ?? films)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            
            completion(timeline)
        }
    }
}

struct Model: TimelineEntry {
    let date: Date
    let data: [Film]
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
        IntentConfiguration(kind: kind, intent: FilmiesConfigurationIntent.self, provider: Provider()) { entry in
            FilmiesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Filmies Launcher")
        .description("Display Trending Films.")
    }
}

struct FilmiesWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Film.getPlaceholderData()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Film.getPlaceholderData()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            FilmiesWidgetEntryView(entry: Model(date: Date(), data: Film.getPlaceholderData()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
