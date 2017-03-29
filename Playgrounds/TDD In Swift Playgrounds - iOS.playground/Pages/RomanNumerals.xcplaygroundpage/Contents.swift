//: [Previous](@previous)

//: ## Roman Numerals Kata
//: Kata Description from [Agile Katas](http://agilekatas.co.uk/katas/RomanNumerals-Kata)
//:
//: The Romans wrote their numbers using letters; specifically the letters 'I' meaning '1', 'V' meaning '5', 'X' meaning '10', 'L' meaning '50', 'C' meaning '100', 'D' meaning '500', and 'M' meaning '1000'. There were certain rules that the numerals followed which should be observed.
//:
//: The symbols 'I', 'X', 'C', and 'M' can be repeated at most 3 times in a row. The symbols 'V', 'L', and 'D' can never be repeated. The '1' symbols ('I', 'X', and 'C') can only be subtracted from the 2 next highest values ('IV' and 'IX', 'XL' and 'XC', 'CD' and 'CM'). Only one subtraction can be made per numeral ('XC' is allowed, 'XXC' is not). The '5' symbols ('V', 'L', and 'D') can never be subtracted.
//:
//: ### Examples
//:
//: A correct implementation should produce the following roman numerals output for the given arabic inputs:
//:
//: * 1 = I
//: * 5 = V
//: * 9 = IX
//: * 10 = X
//: * 50 = L
//: * 90 = XC
//: * 100 = C
//: * 500 = D
//: * 1000 = M
//: * 2499 = MMCDXCIX
//: * 3949 = MMMCMXLIX

import XCTest

//: ### Implementation
//: Write your implementation of the roman numeral converter below. You can use classes, structs, enums or any other types.
func % (base: Int, divider: Int) -> Int {
    return Int(Double(base).truncatingRemainder(dividingBy: Double(divider)))
}

    class RomanNumeralConverter {
        func romanNumeral(number: Int) -> String {
            var result = ""
            
            result += (0 ..< Int(Double(number/10))).map { _ in  "X" }.joined()
            
            switch number % 10 {
            case 1:
                result += "I"
            case 2:
                result += "II"
            case 3:
                result += "III"
            case 4:
                result += "IV"
            case 5:
                result += "V"
            case 6:
                result += "VI"
            case 7:
                result += "VII"
            case 8:
                result += "VIII"
            case 9:
                result += "IX"
            default:
                break;
            }
            
            return result
        }
    }

//: ### Tests
//: Fill in the unit test class to verfiy the functionality of your implementation:

class RomanNumeralConverterTests: XCTestCase {
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testThatOneIsConverted(){
        let converter = RomanNumeralConverter()
        let roman = converter.romanNumeral(number: 1)
        XCTAssertEqual(roman, "I")
    }
    
    func testThatTwoIsConverted(){
        let converter = RomanNumeralConverter()
        let roman = converter.romanNumeral(number: 2)
        XCTAssertEqual(roman, "II")
    }
    
    func testThatFiveIsConverted(){
        let converter = RomanNumeralConverter()
        let roman = converter.romanNumeral(number: 5)
        XCTAssertEqual(roman, "V")
    }
    
    func testThatTeenIsConverted(){
        let converter = RomanNumeralConverter()
        let roman = converter.romanNumeral(number: 14)
        XCTAssertEqual(roman, "XIV")
    }
    
}

TestRunner().runTests(testClass: RomanNumeralConverterTests.self)

//: [Next](@next)
