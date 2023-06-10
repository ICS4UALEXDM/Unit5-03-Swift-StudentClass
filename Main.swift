import Foundation
import Glibc
// creating constants and variables
var errorMessage = ""

// Defining the file paths
let inputFile = "input.txt"
let outputFile = "output.txt"

// opening the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}

// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)

var students = [Student]()

for line in lines {
    var student: Student
    let attributes = line.components(separatedBy: " ")
    if (attributes.count == 4) {
        student = Student(firstName: attributes[0], lastName: attributes[1], grade: Int(attributes[2])!, iep: Bool(attributes[3])!)
    } else {
        student = Student(firstName: attributes[0], middleInitial: attributes[1], lastName: attributes[2], grade: Int(attributes[3])!, iep: Bool(attributes[4])!)
    }
    students.append(student)
}

var outputData = "There are \(students.count) students on the list.\nThe students are:\n"
output.write(outputData.data(using: .utf8)!)

for stu in students {
    outputData = stu.output()
    output.write(outputData.data(using: .utf8)!)
}

class Student {
    var firstName: String
    var middleInitial: String = ""
    var lastName: String
    var grade: Int
    var iep: Bool

    init(firstName: String, middleInitial: String, lastName: String, grade: Int, iep: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleInitial = middleInitial
        self.grade = grade
        self.iep = iep
    }

    init(firstName: String, lastName: String, grade: Int, iep: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.grade = grade
        self.iep = iep
    }

    func output() -> String{
        if (self.middleInitial == "") {
            return "\(self.firstName) \(self.lastName), grade: \(self.grade), iep: \(self.iep)\n"
        } else {
            return"\(self.firstName) \(self.middleInitial) \(self.lastName), grade: \(self.grade), iep: \(self.iep)\n"
        }
    }
}