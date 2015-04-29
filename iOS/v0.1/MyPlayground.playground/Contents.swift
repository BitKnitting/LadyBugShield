//: Playground - noun: a place where people can play

import Cocoa
func test(buf:[UInt8]) -> String
{
    let pH_string = "pH"
    return pH_string
}
var str = "Hello, playground"
var buffer = [UInt8](count: 10, repeatedValue: 0x00)
var buffer[1] = 3
var buf_prt = buffer[1]
let pH_string = test(buffer)