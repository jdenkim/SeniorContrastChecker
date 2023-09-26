//
//  ContentView.swift
//  SeniorContrastChecker
//
//  Created by Jden Kim on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var hexCodeInput: String = "#000000"
    @State private var hexCodeFontInput: String = "#FFFFFF"
    
    @State private var selectedColor: Color = Color(hex: "#000000")!
    @State private var selectedFontColor: Color = Color(hex: "#FFFFFF")!
    
    @State private var isColorPickerVisible = false
    
    @FocusState private var isTextFieldFocused: Bool
  
    

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(selectedColor)
                    .frame(width: 400, height: 100) // Adjusted for a 4:1 aspect ratio
                    .padding()
                    .onTapGesture {
                        // When the rectangle is tapped, toggle the color picker visibility
                        isColorPickerVisible.toggle()
                    }
                
                Text("Senior Color Contrast Checker")
                    .font(.system(size: 24)) // Adjusted font size
                    .foregroundColor(selectedFontColor)
            }
            .frame(maxHeight: 130) // Adjusted for some extra height
            
            HStack{
                VStack{
                    HStack {
                        Text("Background Color")
                        Spacer() // Pushes the ColorPicker to the right
                        ColorPicker("", selection: $selectedColor)
                            .onChange(of: selectedColor, perform: { newValue in
                                hexCodeInput = newValue.toHex
                            })
                    }
                    .frame(width: 170)
                    TextField("Enter Hex Color Code", text: $hexCodeInput)
                        .frame(width: 170)
                        .onChange(of: hexCodeInput, perform: { newValue in
                            if let color = Color(hex: newValue) {
                                selectedColor = color
                            }
                        })
                }
                VStack {
                    // Other content here...

                    Button(action: {
                        // Swap the values of selectedColor and selectedFontColor
                        let temp = selectedColor
                        selectedColor = selectedFontColor
                        selectedFontColor = temp

                        // Swap the hex code inputs as well
                        let tempHex = hexCodeInput
                        hexCodeInput = hexCodeFontInput
                        hexCodeFontInput = tempHex
                    }) {
                        Text("🔄") // Replace "🔄" with the emoji of your choice
                            .accessibilityLabel("Swap Background forground Color")
                         
                    }
                    .frame(maxWidth: .infinity)
                }
               
                   

                
                VStack{
                    HStack {
                        Text("Foreground Color")
                        Spacer() // Pushes the ColorPicker to the right
                        ColorPicker("", selection: $selectedFontColor)
                            .onChange(of: selectedFontColor, perform: { newValue in
                                hexCodeFontInput = newValue.toHex
                            })
                    }
                    .frame(width: 170)
                    TextField("Enter Hex Color Code", text: $hexCodeFontInput)
                        .frame(width: 170)
                        .onChange(of: hexCodeFontInput, perform: { newValue in
                            if let color = Color(hex: newValue) {
                                selectedFontColor = color
                            }
                        })
                }
            }
            .frame(width: 400)
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.white)
                .frame(width: 400)
                .frame(height: 150)
            
                .overlay(
                    VStack{
                        Section(header: Text("7:1 for the broader senior population ").foregroundColor(Color.gray)){
                            let contrastRatio = calculateContrastRatio(selectedColor, selectedFontColor)
                            
                            VStack(spacing: 10) {
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
                            }
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                            
                            VStack(spacing: 0) {
                                HStack {
                                    let contrastRatioDouble = Double(contrastRatio) ?? 0.0
                                    let result = getResult(for: contrastRatioDouble)
                                    
                                    Text(result)
                                        .font(.headline)
                                    
                                        .foregroundColor(getResultTextColor(for: result))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                    }
                )
            
            HStack {
                let contrastRatio = calculateContrastRatio(selectedColor, selectedFontColor)
                let contrastRatioDouble = Double(contrastRatio) ?? 0.0
                let result2 = getNormalAaResult(for: contrastRatioDouble)
                let result3 = getLargelAaResult(for: contrastRatioDouble)
                let result4 = getNormalAaaResult(for: contrastRatioDouble)
                let result5 = getLargelAaaResult(for: contrastRatioDouble)
                
                VStack(spacing: 10){
                    Text("")
                    Text("WCAG AA")
                    Text("WCAG AAA")
                                                   
                }
                .padding()
             
                VStack(spacing: 10){
                    Text("Normal Text")
                    Text(result2)
                    .font(.headline)
                    .foregroundColor(getResultTextColor(for: result2))
                    Text(result4)
                    .font(.headline)
                    .foregroundColor(getResultTextColor(for: result4))
                                    
                }
                .padding()
          
                VStack(spacing: 10){
                    Text("Large Text")
                    Text(result3)
                    .font(.headline)
                    .foregroundColor(getResultTextColor(for: result3))
                    Text(result5)
                    .font(.headline)
                    .foregroundColor(getResultTextColor(for: result5))
                }
                .padding()
            }
            
            

        }
        .frame(width: 500 , height: 550)
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

struct LargeColorPicker: View {
    @Binding var selectedColor: Color
    @Binding var hexCodeInput: String
    
    
    var pickerSize: CGSize // Add a property to specify the picker size

    var body: some View {
        ColorPicker("", selection: $selectedColor)
            .onChange(of: selectedColor, perform: { newValue in
                hexCodeInput = newValue.toHex
            })
            .frame(width: pickerSize.width, height: pickerSize.height) // Apply the specified size
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
           guard let components = cgColor?.components, components.count >= 3 else { return 0.0 }
           
           let red = components[0]
           let green = components[1]
           let blue = components[2]
           
           let sRGBRed = red <= 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4)
           let sRGBGreen = green <= 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4)
           let sRGBBlue = blue <= 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4)
           
           return 0.2126 * sRGBRed + 0.7152 * sRGBGreen + 0.0722 * sRGBBlue
       }
}
