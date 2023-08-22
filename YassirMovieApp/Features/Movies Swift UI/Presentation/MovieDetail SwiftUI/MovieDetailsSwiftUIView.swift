//
//  MovieDetailsSwiftUIView.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 21/08/2023.
//

import SwiftUI


struct MovieDetailsSwiftUIView: View {
    let title: String
    let subtitle: String
    let description: String
    let image: String

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(20)
            Text(title)
                .font(.largeTitle)
            Text(subtitle)
                .font(.title)
            Text(description)
                .font(.title)
           

        }
        .padding()
    }
}

//struct MovieDetailsSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//       // MovieDetailsSwiftUIView()
//    }
//}
