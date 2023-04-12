//
//  ContentView.swift
//  ArrowShape
//
//  Created by Farhad Bagherzadeh on 5/2/2023.
//

import SwiftUI

struct ContentView: View {
  @State private var lineWidth: Double = 8

  @State private var colorCycle = 0.0
  @State var xStartPoint = 0.5
  @State var yStartPoint = 0.5
  @State var xEndPoint = 0.0
  @State var yEndPoint = 0.3

  var body: some View {
    // Arrow
//    VStack {
//      Arrow()
//        .stroke(lineWidth: lineWidth)
//        .frame(width: 300, height: 500)
//        .contentShape(Rectangle())
//        .onTapGesture {
//          withAnimation {
//            lineWidth = Double((0...20).randomElement() ?? 0)
//          }
//        }
//        .padding(.vertical)
//
//
//      VStack(alignment: .leading) {
//        Text("Line thickness:")
//        Slider(value: $lineWidth, in: (0...20))
//      }
//      .padding(.horizontal)
//      .padding()
//    }

    // ColorCyclingRectangle
    VStack {
      ColorCyclingRectangle(
        amount: colorCycle,
        xStartPoint: xStartPoint,
        yStartPoint: yStartPoint,
        xEndPoint: xEndPoint,
        yEndPoint: yEndPoint
      )
      .frame(width: 300, height: 300)

      Slider(value: $colorCycle)
      VStack(alignment: .leading, spacing: .zero) {
        Text("xStartPoint")
        Slider(value: $xStartPoint, in: (0.0...1.0))
      }.padding(.vertical)

      VStack(alignment: .leading, spacing: .zero) {
        Text("yStartPoint")
        Slider(value: $yStartPoint, in: (0.0...1.0))
      }.padding(.vertical)

      VStack(alignment: .leading, spacing: .zero) {
        Text("xEndPoint")
        Slider(value: $xEndPoint, in: (0.0...1.0))
      }.padding(.vertical)

      VStack(alignment: .leading, spacing: .zero) {
        Text("yEndPoint")
        Slider(value: $yEndPoint, in: (0.0...1.0))
      }.padding(.vertical)

    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

// MARK: -ColorCyclingRectangle view
struct ColorCyclingRectangle: View {
  var amount = 0.0
  var steps = 100

  var xStartPoint = 0.5
  var yStartPoint = 0.5
  var xEndPoint = 0.0
  var yEndPoint = 0.3

  var body: some View {
    let a = UnitPoint(x: xStartPoint, y: yStartPoint)
    let b = UnitPoint(x: xEndPoint, y: yEndPoint)
    ZStack {
      ForEach(0..<steps, id: \.self) { value in
        RoundedRectangle(cornerRadius: 10)
          .inset(by: Double(value))
          .strokeBorder(
              LinearGradient(
                  gradient: Gradient(colors: [
                      color(for: value, brightness: 1),
                      color(for: value, brightness: 0.2)
                  ]),
                  startPoint: a,
                  endPoint: b
              ),
              lineWidth: 2
          )
//          .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
      }
    }
    .drawingGroup()
  }

  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(steps) + amount

    if targetHue > 1 {
      targetHue -= 1
    }

    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}


// MARK: -Arrow shape
struct Arrow: Shape {

  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: rect.midX, y: .zero))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
    path.addLine(to: CGPoint(x: rect.maxX - rect.maxX / 4, y: rect.maxY / 3))
    path.addLine(to: CGPoint(x: rect.maxX - rect.maxX / 4, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX - (rect.maxX / 4) * 3, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX - (rect.maxX / 4) * 3, y: rect.maxY / 3))
    path.addLine(to: CGPoint(x: .zero, y: rect.maxY / 3))
    path.addLine(to: CGPoint(x: rect.midX, y: .zero))

    path.closeSubpath()

    return path
  }
}
