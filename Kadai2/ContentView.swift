//
//  ContentView.swift
//  Kadai2
//
import SwiftUI

struct ContentView: View {
    @State private var ansewrText: String = "Label"
    @State private var selectedOpt = OptType.add
    @State var textNum1: String = ""
    @State var textNum2: String = ""

    var body: some View {
        ZStack {
            Color.white.opacity(0.01)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                    print("close keyboadr")
                }

            VStack(spacing: 20.0) {
                TextField("", text: Binding(
                            get: { textNum1 },
                            set: { textNum1 = $0.filter {"0123456789".contains($0)}}))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)

                TextField("", text: Binding(
                            get: { textNum2 },
                            set: { textNum2 = $0.filter {"0123456789".contains($0)}}))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)

                Picker("", selection: $selectedOpt) {
                    ForEach(OptType.allCases, id: \.self) { opt in
                        Text(opt.rawValue).tag(OptType?.some(opt))
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    self.ansewrText = calcAns(type: selectedOpt, Double(self.textNum1), Double(self.textNum2))
                }, label: {
                    Text("Button")
                })

                Text(self.ansewrText)
            }.padding()
        }
    }
}

enum OptType: String, CaseIterable {
    case add = "+"
    case sub = "-"
    case mul = "×"
    case div = "÷"
}

func calcAns(type: OptType, _ num1: Double?, _ num2: Double?) -> String {
    if num1 == nil || num2 == nil {
        return "数字を入力してください"
    } else {
        var tmpCalc: Double
        switch type {
        case .add:
            tmpCalc = num1! + num2!
        case .sub:
            tmpCalc = num1! - num2!
        case .mul:
            tmpCalc = num1! * num2!
        case .div:
            if num2 == 0 {
                return "割る数には0以外を入力してください"
            } else {
                tmpCalc = num1! / num2!
            }
        }
        return String(format: "%.1f", tmpCalc)
    }
}

// 画面をタップするとキーボードを閉じる & 入力が確定する
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().environmentObject(Model())
        ContentView()
    }
}
