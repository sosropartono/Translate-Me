import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var translatedText = ""
    @State private var translations: [Translation] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter text to translate", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Translate") {
                    translateText()
                }
                .padding()
                
                TextEditor(text: $translatedText)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
                    .padding()
                    .border(Color.gray, width: 1)
                    .cornerRadius(8)
                
                List {
                    ForEach(translations) { translation in
                        Text("\(translation.original) -> \(translation.translated)")
                    }
                }
                .listStyle(InsetListStyle())
                .padding()
                
                Button("Clear History") {
                    clearTranslationHistory()
                }
                .foregroundColor(.red)
                .padding()
            }
            .navigationTitle("Translate Me")
        }
    }
    
    private func translateText() {
        guard !inputText.isEmpty else { return }
        
        // Call translation API here (e.g., using URLSession)
        let translation = Translation(original: inputText, translated: "Translated Text") // Replace with actual translation
        
        translatedText = translation.translated
        translations.append(translation)
        
        // TODO: Save translation to Firestore
        // FirestoreManager.saveTranslation(translation)
        
        // Clear input text after translation
        inputText = ""
    }
    
    private func clearTranslationHistory() {
        translations.removeAll()
        
        // TODO: Delete all translations from Firestore
        // FirestoreManager.deleteAllTranslations()
    }
}

struct Translation: Identifiable {
    let id = UUID()
    let original: String
    let translated: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
