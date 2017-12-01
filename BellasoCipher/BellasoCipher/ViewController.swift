//
//  ViewController.swift
//  BellasoCipher
//
//  Created by Alexandra Neamtu on 24/10/2017.
//  Copyright © 2017 Alexandra Neamtu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var keywordField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        messageField.text=""
        keywordField.text=""
        textView.text=""
    }
    
    @IBAction func encrypt(_ sender: Any) {
        self.view.endEditing(true)
        textView.text=""
        if (messageField.text?.isEmpty)! {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",       delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
        }
        if (keywordField.text?.isEmpty)! {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
            }
        
        if (keywordField.text == " ") {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
        }
        let message = messageField.text!
        let keyword = keywordField.text!
        

        if !validateEncrypt(message: message){
            let alert : UIAlertView = UIAlertView(title: "Error", message: "The message should contain only lowercase letters",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "The message should contain only letters"
            return
        }
        if !validateDecrypt(message: keyword){
            let alert : UIAlertView = UIAlertView(title: "Error", message: "The keyword should contain only uppercase letters",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "The keyword should contain only letters"
            return
        }
    
        
        var texttt:String = ""
        var arrayEncryptedNumeric = [String]()
        arrayEncryptedNumeric = encryption(message: message,keyword: keyword)
        var arrayEncryptedText = [String]()
        arrayEncryptedText = numericalToText(numerical: arrayEncryptedNumeric)
        for letter in arrayEncryptedText{
            texttt = texttt + letter.uppercased()
        }
        textView.text! = texttt
    }
    
    @IBAction func decrypt(_ sender: Any) {
        self.view.endEditing(true)
        textView.text=""
        if (messageField.text?.isEmpty)! {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",       delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
        }
        if (keywordField.text?.isEmpty)! {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
        }
        
        if (keywordField.text == " ") {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Invalid message or keyword",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "Invalid message or keyword"
            return
        }
        
        let message = messageField.text!
        let keyword = keywordField.text!
        
        
        
        if !validateDecrypt(message: message){
            let alert : UIAlertView = UIAlertView(title: "Error", message: "The message should contain only uppercase letters",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "The message should contain only letters"
            return
        }
        if !validateDecrypt(message: keyword){
            let alert : UIAlertView = UIAlertView(title: "Error", message: "The keyword should contain only uppercase letters",delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            //textView.text! = "The keyword should contain only letters"
            return
        }
        
    
        var texttt:String = ""
        var arrayDecryptedNumeric = [String]()
        arrayDecryptedNumeric = decryption(message: message,keyword: keyword)
        var arrayDecryptedText = [String]()
        arrayDecryptedText = numericalToText(numerical: arrayDecryptedNumeric)
        for letter in arrayDecryptedText{
            texttt = texttt + letter.lowercased()
        }
        textView.text! = texttt
    }
}




func validateEncrypt(message: String)->Bool{
    for letter in message{
        
        if !lowercase.contains(String(letter)){
            print("letter")
            return false;
        }
    }
    let toValidate = message.lowercased()
    for letter in toValidate{
        let keyNotExists = possiblecharcters[String(letter)] == nil
        if keyNotExists{
            return false
        }
    }
    return true
}


func validateDecrypt(message: String)->Bool{
    for letter in message{
        if !uppercase.contains(String(letter)){
            return false;
        }
    }
    let toValidate = message.lowercased()
    for letter in toValidate{
        let keyNotExists = possiblecharcters[String(letter)] == nil
        if keyNotExists{
            return false
        }
    }
    return true
}





func messageToNumerical(message:String) -> [String]{
    let text = message.lowercased()
    var numerical = [String]()
    for letter in text{
        let num = possiblecharcters[String(letter)]
        numerical.append(num!)
    }
   return numerical
}

func encryption(message:String, keyword:String) -> [String]{
    var arrayMessage = [String]()
    arrayMessage = messageToNumerical(message: message)
    var arrayKeyword = [String]()
    arrayKeyword = messageToNumerical(message: keyword)
    let len = arrayKeyword.count
    var encryptedArray = [String]()
    let times = arrayMessage.count/len
    
    if(message.count < keyword.count){
        for index in 0...arrayMessage.count-1{
            var numeric = (Int(arrayMessage[index])! + Int(arrayKeyword[index])!)
            numeric = numeric % 27
            encryptedArray.append(String(numeric))
        }
    }
    else{
        var numerical = 0
        for _ in 0...times-1{
            for index in 0...len-1{
                print("--")
                print(numerical+index)
                print(index)
                print(arrayMessage[numerical+index])
                print(arrayKeyword[index])
                print("--")
                var numeric = (Int(arrayMessage[numerical+index])! + Int(arrayKeyword[index])!)
                numeric = numeric % 27
                print("####")
                print(numeric)
                print("####")
                encryptedArray.append(String(numeric))
            }
            numerical = numerical + len
        }
        

        if numerical != arrayMessage.count{
            let extra = arrayMessage.count - numerical
            for index in 0...extra-1{
                var numeric = (Int(arrayMessage[numerical+index])! + Int(arrayKeyword[index])!)
                numeric = numeric % 27
                encryptedArray.append(String(numeric))
            }
        }
    }
    
    return encryptedArray
}



func decryption(message:String, keyword:String) -> [String]{
    var arrayMessage = [String]()
    arrayMessage = messageToNumerical(message: message)
    var arrayKeyword = [String]()
    arrayKeyword = messageToNumerical(message: keyword)
    let len = arrayKeyword.count
    var decryptedArray = [String]()
    let times = arrayMessage.count/len
    
    if(message.count < keyword.count){
        for index in 0...arrayMessage.count-1{
            var numeric = (Int(arrayMessage[index])! - Int(arrayKeyword[index])!)
            numeric = numeric % 27
            decryptedArray.append(String(numeric))
        }
    }
    else{
        var numerical = 0
        for _ in 0...times-1{
            for index in 0...len-1{
                print("--")
                print(numerical+index)
                print(index)
                print(arrayMessage[numerical+index])
                print(arrayKeyword[index])
                print("--")
                var numeric = (Int(arrayMessage[numerical+index])! - Int(arrayKeyword[index])!)
                numeric = numeric % 27
                print("####")
                print(numeric)
                print("####")
                decryptedArray.append(String(numeric))
            }
            numerical = numerical + len
        }
        
        
        if numerical != arrayMessage.count{
            print("!!!!!!!!!!!!!")
            let extra = arrayMessage.count - numerical
            for index in 0...extra-1{
                var numeric = (Int(arrayMessage[numerical+index])! - Int(arrayKeyword[index])!)
                numeric = numeric % 27
                print("####")
                print(numeric)
                print("####")
                decryptedArray.append(String(numeric))
            }
        }
    
    }
    return decryptedArray
}


func numericalToText(numerical:[String])->[String]{
    var text = [String]()
    for num in numerical{
        if Int(num)! < 0{
            let num2 = Int(num)! + 27
            text.append(findKeyForValue(value: String(num2), dictionary: possiblecharcters)!)
        }
        else{
            text.append(findKeyForValue(value: num, dictionary: possiblecharcters)!)
        }
    }
    return text
}

func findKeyForValue(value: String, dictionary: [String: String]) ->String?
{
    for (key,val) in dictionary
    {
        if (val == value)
        {
            return key
        }
    }
    return nil
}

let lowercase=[" ","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
let uppercase=[" ","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

let possiblecharcters = [ " ": "0",
                          "a": "1",
                          "b": "2",
                          "c": "3",
                          "d": "4",
                          "e": "5",
                          "f": "6",
                          "g": "7",
                          "h": "8",
                          "i": "9",
                          "j": "10",
                          "k": "11",
                          "l": "12",
                          "m": "13",
                          "n": "14",
                          "o": "15",
                          "p": "16",
                          "q": "17",
                          "r": "18",
                          "s": "19",
                          "t": "20",
                          "u": "21",
                          "v": "22",
                          "w": "23",
                          "x": "24",
                          "y": "25",
                          "z": "26"]
