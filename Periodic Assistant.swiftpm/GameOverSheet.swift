import SwiftUI

struct GameOverSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State var wrong: Int
    @State var correct: Int
    @State var questionsLeft: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Stats:")
                        .font(.largeTitle.bold())
                        .padding()
                    VStack(spacing: 15) {
                        HStack {
                            Text("You answered")
                            Text(String(correct))
                                .font(.title.bold())
                            Text("questions correctly")
                        }
                        HStack {
                            Text("You could not answer")
                            Text(String(wrong))
                                .font(.title.bold())
                            Text("times")
                        }
                        if questionsLeft > 0 {
                            HStack {
                                Text("You attempted")
                                Text(String(20 - questionsLeft))
                                    .font(.title.bold())
                                Text("questions")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Game Over! 🎉") 
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.caption.bold())
                        .padding(5)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .onAppear {
            simpleSuccess()
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
