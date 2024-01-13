//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Mit Sheth on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questinNumber = 0
    @State private var gameOver = false
    @State private var finalScore = 0
    var body: some View {
        ZStack {
            Color(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 220.0 / 255.0)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                Spacer()
                VStack {
                    Text("Can you guess the flag of")
                        .font(.subheadline.weight(.semibold))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                    }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 10)
                    }
                }
                Spacer()
                Spacer()
                Text("Your score is \(score)/8")
                    .fontWeight(.semibold)
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
             Text("Your score is \(score)/8")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Start new game", action: askQuestion)
        } message: {
            Text("Your final score is \(finalScore)/8")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Amazing! Correct Answer!!"
            score += 1
            questinNumber += 1
        } else {
            scoreTitle = "Oops, Wrong Answer! That's the flag of \(countries[number])"
            questinNumber += 1
        }
        showingScore = true
    }
    func askQuestion() {
        if (questinNumber < 8) {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            gameOver = true
            finalScore = score
            score = 0
            questinNumber = 0
        }
    }
}

#Preview {
    ContentView()
}
