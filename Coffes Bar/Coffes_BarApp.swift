//
//  Coffes_BarApp.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 09/08/23.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct Coffes_BarApp: App {
  var body: some Scene {
    // PARA CACHEAR A IMAGEM E EVITAR RERENDER
    let urlImageService = URLImageService(
      fileStore: URLImageFileStore(),
      inMemoryStore: URLImageInMemoryStore()
    )
    return WindowGroup {
      RootViewScreen()
        .environment(\.urlImageService, urlImageService)
    }
  }
}
