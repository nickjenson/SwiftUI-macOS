//
//  ContentView.swift
//  CowBull
//
//  Created by Nick Jenson on 4/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var guess = ""
    @State private var guesses = [String]()
    @State private var answer = ""
    @State private var isGameOver = false
    
    var body: some View {
        // remove automatic SwiftUI spacing
        VStack(spacing: 0) {
            HStack {
                TextField("Guess...", text: $guess)
                    .onSubmit(submit)
                Button("Go", action: submit)
            }
            .padding()
            
            List(guesses, id: \.self) { guess in
                HStack {
                    Text(guess)
                    Spacer()
                    Text(result(for: guess))
                }
            }
            .listStyle(.sidebar)
        } // modifiers can stack, they combine
        .frame(width: 250)
        .frame(minHeight: 300)
        .navigationTitle("Cows and Bulls")
        
        .onAppear(perform: startNew)
        .alert("You win!", isPresented: $isGameOver) {
            Button("OK", action: startNew)
        } message: {
            Text("Congratulations! Click OK to play again.")
        }
        // simple touchbar view
        .touchBar {
            HStack {
                Text("Guesses: \(guesses.count)")
                    .touchBarItemPrincipal()
                Spacer(minLength: 200)
            }
        }
    }
    func startNew() {
        guess = ""
        guesses.removeAll()
        answer = ""
        // creates array, with unique numbers, shuffles them
        let numbers = (0...9).shuffled()
        for i in 0..<4 {
            answer.append(String(numbers[i]))
        }
        
    }
    func submit() {
        guard Set(guess).count == 4 else { return }
        guard guess.count == 4 else { return }
        // only want chars "0123456789", so we want to exclude everything else
        let badChars = CharacterSet(charactersIn: "0123456789").inverted
        guard guess.rangeOfCharacter(from: badChars) == nil else {
            return
        }
        
        // not accept duplicates
        guard !guesses.contains(guess) else { return }
        
        withAnimation {
            guesses.insert(guess, at: 0)
        }
        
        if result(for: guess).contains("4b") {
            isGameOver = true
        }
        guess = ""
        
    }
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        
        let letters = Array(guess)
        let answers = Array(answer)
        // enumerated() returns array item as well as its index
        for (index, letter) in letters.enumerated() {
            if letter == answers[index] {
                bulls += 1
            } else if answers.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
