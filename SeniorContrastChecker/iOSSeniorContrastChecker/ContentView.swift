//
//  ContentView.swift
//  iOSSeniorContrastChecker
//
//  Created by Jden Kim on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var hexCodeInput: String = "#000000"
    @State private var hexCodeFontInput: String = "#FFFFFF"
    
    @State private var selectedColor: Color = Color(hex: "#000000")!
    @State private var selectedFontColor: Color = Color(hex: "#FFFFFF")!

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(selectedColor)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9 * 0.16) // Adjusted for a 7:2.5 aspect ratio
                        .padding()
                    
                    Text("Senior Color Contrast Checker")
                        .font(.system(size: UIScreen.main.bounds.width * 0.9 * 0.2857 * 0.2)) // Adjusted for 80% of the RoundedRectangle's height
                        .foregroundColor(selectedFontColor)
                }
                .frame(maxHeight: UIScreen.main.bounds.width * 0.9 * 0.2857 * 1) // Adjusted for some extra height
                
                VStack {
                    Form {
                        let contrastRatio = calculateContrastRatio(selectedColor, selectedFontColor)
                        
                        Section(header: Text("Background Color")) {
                            
                            //
                            TextField("Enter Hex Color Code", text: $hexCodeInput)
                                .onChange(of: hexCodeInput, perform: { newValue in
                                    if let color = Color(hex: newValue) {
                                        selectedColor = color
                                    }
                                })
                            
                            
                            
                            HStack {
                                Text("Select Color")
                                    .frame(width: 160, alignment: .leading)
                                ColorPicker("", selection: $selectedColor)
                                    .frame(maxHeight: 30)
                                    .onChange(of: selectedColor, perform: { newValue in
                                        hexCodeInput = newValue.toHex
                                    })
                            }
                            
                            //
                        
                    }
                        Section(header: Text("Foreground Color")) {
                            
                            
                            TextField("Enter Hex Font Color Code", text: $hexCodeFontInput)
//                                .padding()
                                .frame(maxHeight: 30)
                                .onChange(of: hexCodeFontInput, perform: { newValue in
                                    if let color = Color(hex: newValue) {
                                        selectedFontColor = color
                                    }
                                })
                            
                                ColorPicker("Select Font Color", selection: $selectedFontColor)
                                    .frame(maxHeight: 30)
                                    .onChange(of: selectedFontColor, perform: { newValue in
                                        hexCodeFontInput = newValue.toHex
                                    })
                            }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        Section(header: Text("7:1 for the broader senior population ")) {
                            VStack(spacing: 10) { // Spacing between the first and second VStack
                                HStack {
                                    Text("")
                                    
                                    Text("\(String(format: "%.2f", contrastRatio)) : 1")
                                        .font(.system(size: 30).bold())
                                        .frame(maxHeight: 30)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                
                                HStack {
                                    Text("Contrast")
                                        .frame(maxHeight: 10)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                //                                .frame(maxHeight: 200)
                            }
                            //                            .padding()
                        

                            VStack(spacing: 0) { // Spacing between the second and third VStack
                                HStack {
                                    let contrastRatioDouble = Double(contrastRatio) ?? 0.0
                                    let result = getResult(for: contrastRatioDouble)
                                    
                                    Text(result)
                                        .font(.headline)
                                        .frame(maxHeight: 100)
                                        .foregroundColor(getResultTextColor(for: result))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
//                            .padding()
                        }
                        
//                        HStack {
//                            Text("Text:")
//                                .font(.system(size: 12)) // Adjust the font size as needed
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//
//                            Text(getWcagResult(for: contrastRatio))
//                                .font(.system(size: 12))
//                                .foregroundColor(getResultTextColor(for: getWcagResult(for: contrastRatio)))
//
//                            Text("AA")
//                                .font(.system(size: 12)) // Adjust the font size as needed
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//
//                            Text(getWcagResult(for: contrastRatio))
//                                .font(.system(size: 12))
//                                .foregroundColor(getResultTextColor(for: getWcagResult(for: contrastRatio)))
//
//                            Text("AAA")
//                                .font(.system(size: 12)) // Adjust the font size as needed
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//                        }
//                        HStack {
//                            Text("Large Text:")
//                                .font(.system(size: 12))
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//
//                            Text(getWcagResult(for: contrastRatio))
//                                .font(.system(size: 12))
//                                .foregroundColor(getResultTextColor(for: getWcagResult(for: contrastRatio)))
//
//                            Text("AA")
//                                .font(.system(size: 12))
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//
//                            Text(getWcagResult(for: contrastRatio))
//                                .font(.system(size: 12))
//                                .foregroundColor(getResultTextColor(for: getWcagResult(for: contrastRatio)))
//
//                            Text("AAA")
//                                .font(.system(size: 12))
//                                .padding()
//                                .frame(maxHeight: 15)
//                                .foregroundColor(Color.black)
//                        }
                        Section() {
                        
                            
                           
                                List {
                                    // Header row
                                    HStack {
                                        Text("")
                                            .fontWeight(.bold)
                                            .frame(maxHeight: 10)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer()
                                        Text("Normal Text")
//                                            .fontWeight(.bold)
                                        
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("Large Text")
//                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    
                                    // First row
                                    HStack {
                                        Text("WCAG AA")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: 10)
                                        
                                        let contrastRatioDouble = Double(contrastRatio) ?? 0.0
                                        let result2 = getNormalAaResult(for: contrastRatioDouble)
                                        let result3 = getLargelAaResult(for: contrastRatioDouble)
                                        
                                        Text(result2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.headline)
                                            .foregroundColor(getResultTextColor(for: result2))
                                        
                                        Text(result3)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.headline)
                                            .foregroundColor(getResultTextColor(for: result3))
                                        
                                    }
                                    
                                    // Second row
                                    HStack {
                                        Text("WCAG AAA")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: 10)
                                        
                                        let contrastRatioDouble = Double(contrastRatio) ?? 0.0
                                        let result4 = getNormalAaaResult(for: contrastRatioDouble)
                                        let result5 = getLargelAaaResult(for: contrastRatioDouble)
                                        
                                        Text(result4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.headline)
                                            .foregroundColor(getResultTextColor(for: result4))
                                        Text(result5)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.headline)
                                            .foregroundColor(getResultTextColor(for: result5))
                                    }
                                 }
                                
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Color Checker")
        }
    }
    
    func calculateContrastRatio(_ color1: Color, _ color2: Color) -> Double {
        let luminance1 = color1.relativeLuminance
        let luminance2 = color2.relativeLuminance
        
        let ratio = (max(luminance1, luminance2) + 0.05) / (min(luminance1, luminance2) + 0.05)
        return ratio // Return the contrast ratio as a Double
    }

    func getWcagResult(for contrastRatio: Double) -> String {
        if contrastRatio < 4.5 {
            return "Fail"
        } else if contrastRatio < 7.0 {
            return "Pass"
        } else {
            return "Pass"
        }
    }
    
    func getNormalAaResult(for contrastRatio: Double) -> String {
        if contrastRatio < 4.5 {
            return "❌ Fail"
        } else {
            return "✅ Pass"
        }
    }
    
    func getLargelAaResult(for contrastRatio: Double) -> String {
        if contrastRatio < 3 {
            return "❌ Fail"
        } else {
            return "✅ Pass"
        }
    }
    
    func getNormalAaaResult(for contrastRatio: Double) -> String {
        if contrastRatio < 7 {
            return "❌ Fail"
        } else {
            return "✅ Pass"
        }
    }
    
    func getLargelAaaResult(for contrastRatio: Double) -> String {
        if contrastRatio < 4.5 {
            return "❌ Fail"
        } else {
            return "✅ Pass"
        }
    }
    
    func getResult(for contrastRatio: Double) -> String {
        if contrastRatio < 4.5 {
            return "Fail"
        } else if contrastRatio < 7.0 {
            return "Pass"
        } else {
            return "Pass (Good for senior 65 and older)"
        }
    }
    
    func getResultTextColor(for result: String) -> Color {
        switch result {
        case "Fail":
            return Color.red
        case "Pass":
            return Color.green
        case "Pass (Good for senior 65 and older)":
            return Color.green
        default:
            return Color.primary
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init?(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        guard scanner.scanString("#", into: nil), scanner.scanHexInt64(&rgb) else {
            return nil
        }

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
    var toHex: String {
        guard let components = cgColor?.components else { return "" }
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
    
    var relativeLuminance: Double {
        let red = cgColor?.components?[0] ?? 0
        let green = cgColor?.components?[1] ?? 0
        let blue = cgColor?.components?[2] ?? 0
        
        let sRGBRed = red <= 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4)
        let sRGBGreen = green <= 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4)
        let sRGBBlue = blue <= 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4)
        
        return 0.2126 * sRGBRed + 0.7152 * sRGBGreen + 0.0722 * sRGBBlue
    }
}
