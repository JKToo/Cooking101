//
//  Converter.swift
//  Cook Book
//
//  Created by Justin on 4/10/22.
//

import Foundation

extension Double {
    func flounce() -> String {
        let value = self
        let cups = String(format: "%.3f", value/8)
        let gallons = String(format: "%.3f", value / 128)
        let quarts = String(format: "%.3f", value / 32)
        let tablespoon = String(format: "%.3f", value * 2)
        let teaspoon = String(format: "%.3f", value * 6)
        let mililiter = String(format: "%.3f", value * 29.57353)
        
        let measured = "Cups: \(cups)\nGallons: \(gallons)\nQuarts: \(quarts)\nTeaspoon: \(teaspoon)\nTablespoon: \(tablespoon)\nMililiter: \(mililiter)"
        return measured
    }
    func teaspoon() -> String {
        let value = self
        let cups = String(format: "%.3f", value/48)
        let gallons = String(format: "%.3f", value / 768)
        let quarts = String(format: "%.3f", value / 192)
        let tablespoon = String(format: "%.3f", value / 3)
        let floz = String(format: "%.3f", value / 6)
        let mililiter = String(format: "%.3f", value * 4.928922)
        
        let measured = "Cups: \(cups)\nGallons: \(gallons)\nQuarts: \(quarts)\nFluid Oz: \(floz)\nTablespoon: \(tablespoon)\nMililiter: \(mililiter)"
        return measured
    }
    
    func tablespoon() -> String{
        let value = self
        let cups = String(format: "%.3f", value/16)
        let gallons = String(format: "%.3f", value / 256)
        let quarts = String(format: "%.3f", value / 64)
        let teaspoon = String(format: "%.3f", value * 3)
        let floz = String(format: "%.3f", value / 2)
        let mililiter = String(format: "%.3f", value * 14.787)
        
        let measured = "Cups: \(cups)\nGallons: \(gallons)\nQuarts: \(quarts)\nFluid Oz: \(floz)\nTeaspoon: \(teaspoon)\nMililiter: \(mililiter)"
        return measured
    }
    
    func cups() -> String{
        let value = self
        let tablespoon = String(format: "%.3f", value * 16)
        let gallons = String(format: "%.3f", value / 16)
        let quarts = String(format: "%.3f", value / 4)
        let teaspoon = String(format: "%.3f", value * 48)
        let floz = String(format: "%.3f", value * 8)
        let mililiter = String(format: "%.3f", value * 236.588236)
        
        let measured = "Tablespoon: \(tablespoon)\nGallons: \(gallons)\nQuarts: \(quarts)\nFluid Oz: \(floz)\nTeaspoon: \(teaspoon)\nMililiter: \(mililiter)"
        return measured
    }
    
    func quarts() -> String{
        let value = self
        let cups = String(format: "%.3f", value * 4)
        let gallons = String(format: "%.3f", value / 4)
        let tablespoon = String(format: "%.3f", value * 64)
        let teaspoon = String(format: "%.3f", value * 192)
        let floz = String(format: "%.3f", value * 32)
        let mililiter = String(format: "%.3f", value * 946.352946)
        
        let measured = "Cups: \(cups)\nGallons: \(gallons)\nTablespoon: \(tablespoon)\nFluid Oz: \(floz)\nTeaspoon: \(teaspoon)\nMililiter: \(mililiter)"
        return measured
    }
    
    func gallon() -> String{
        let value = self
        let cups = String(format: "%.3f", value * 16)
        let tablespoon = String(format: "%.3f", value * 256)
        let quarts = String(format: "%.3f", value * 4)
        let teaspoon = String(format: "%.3f", value * 768)
        let floz = String(format: "%.3f", value * 128)
        let mililiter = String(format: "%.3f", value * 3785)
        
        let measured = "Cups: \(cups)\nTablespoon: \(tablespoon)\nQuarts: \(quarts)\nFluid Oz: \(floz)\nTeaspoon: \(teaspoon)\nMililiter: \(mililiter)"
        return measured
    }
    
    func ml() -> String{
        let value = self
        let cups = String(format: "%.3f", value / 236.588236)
        let gallons = String(format: "%.3f", value / 3785)
        let quarts = String(format: "%.3f", value / 946.352946)
        let teaspoon = String(format: "%.3f", value * 4.928922)
        let floz = String(format: "%.3f", value / 29.57353)
        let tablespoon = String(format: "%.3f", value / 14.787)
        
        let measured = "Cups: \(cups)\nGallons: \(gallons)\nQuarts: \(quarts)\nFluid Oz: \(floz)\nTeaspoon: \(teaspoon)\nTablespoon: \(tablespoon)"
        return measured
    }
}
