import SwiftUI

struct ContentView: View {
    @State private var currentRange = "Upto 20"
    @State private var minimum = 1
    @State private var maximum = 20
    
    @State private var askable: [Int] = [0]
    @State private var currentAtomicNumber = 1
    
    @State private var wrong = 0
    @State private var correct = 0
    
    @State private var answerRevealed = false
    @State private var isGameOver = false
    @State private var showingSettings = false
    
    @State private var bgColor = Color.secondary
    @State private var showValency = false
    @State private var showElectronicConfig = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("What's the element with the Atomic Number:")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    ZStack {
                        ZStack {
                            HStack {
                                VStack {
                                    Text(String(currentAtomicNumber))
                                        .font(.system(.largeTitle, design: .rounded))
                                        .bold()
                                        .scaleEffect(answerRevealed ? 0.5 : 1)
                                        .padding(answerRevealed ? .leading : .all, 5)
                                    if answerRevealed { Spacer() }
                                }
                                if answerRevealed{ Spacer() }
                            }
                        }
                        if answerRevealed {
                            VStack {
                                Text(dictionary[currentAtomicNumber] ?? "")
                                    .font(.system(.title, design: .rounded))
                                if showValency {
                                    Text("Valency: Coming Soon")
                                        .font(.system(.headline, design: .rounded))
                                }
                                if showElectronicConfig {
                                    Text(electronicConfigs[currentAtomicNumber] ?? "")
                                        .font(.system(.body, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            } 
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: 400)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(15)
                    .padding(20)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    if !answerRevealed {
                        Button ("Reveal Answer") { answerRevealed.toggle() } 
                            .buttonStyle(.bordered)
                    } else {
                        HStack {
                            Button {
                                simpleSuccess()
                                askable.removeAll(where: {$0 == currentAtomicNumber} )
                                correct += 1
                                bgColor = Color.green
                                randomNumber()
                                answerRevealed.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    bgColor = Color.secondary
                                }
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)                                    
                                    .font(.title2.bold())
                            }.buttonStyle(.bordered)
                                .foregroundColor(.blue)
                            Button {
                                wrongHaptic()
                                wrong += 1
                                bgColor = Color.red 
                                randomNumber()
                                answerRevealed.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    bgColor = Color.secondary
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .font(.title2.bold())
                            } .buttonStyle(.bordered)
                        }
                    }
                }
                
                if wrong > 0 || correct > 0 {
                    VStack {
                        Spacer()
                        Button("End Game") {
                            simpleSuccess()
                            isGameOver = true
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Reset") {
                            simpleSuccess()
                            reset()
                        }
                    }
                    .padding(20)
                }
            }  .navigationBarTitleDisplayMode(.inline)
                .toolbar { 
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
        } .navigationViewStyle(.stack)
            .sheet(isPresented: $isGameOver, onDismiss: reset) {
                GameOverSheet(wrong: wrong, correct: correct, questionsLeft: askable.count) 
            }
            .sheet(isPresented: $showingSettings, onDismiss: reset) {
                Settings(minimum: $minimum, maximum: $maximum, currentRange: $currentRange, showValency: $showValency, showElectronicConfig: $showElectronicConfig)
            }
            .onAppear(perform: reset)
            .animation(.default, value: answerRevealed)
            .animation(.default, value: bgColor)
    }
    
    
    func randomNumber() {
        if askable.count == 0 {
            isGameOver = true
        } else {
            let previous = currentAtomicNumber
            for _ in 1...10 {
                let new = askable.randomElement() ?? 0
                if previous != new {
                    currentAtomicNumber = new
                    break
                }
            }
        }
    }
    
    func reset() {
        askable = [Int](currentRange == "Upto 20" ? 1...20 : minimum...maximum)
        wrong = 0
        correct = 0
        answerRevealed = false
        randomNumber()
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func wrongHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
