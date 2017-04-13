//
//  ViewController.swift
//  SwiftDataContainerSingleton
//
//  Created by Duncan Champney on 4/19/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
  
  @IBOutlet weak var textField: UITextField!
  
  //-------------------------------------------------------------------------------------------------------
  // MARK: - UIViewController methods -
  //-------------------------------------------------------------------------------------------------------
  
  override func viewWillAppear(_ animated: Bool)
  {
    //Load the value "someInt" from our shared ata container singleton
    let value = DataContainerSingleton.sharedDataContainer.someInt ?? 0
    
    //Install the value into the text field.
    textField.text =  "\(value)"
  }
  
  
  //-------------------------------------------------------------------------------------------------------
  // MARK: - UITextFieldDelegate methods -
  //-------------------------------------------------------------------------------------------------------
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    textField.resignFirstResponder()
    return true
  }
  
  //-------------------------------------------------------------------------------------------------------
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
  {
    //Save the changed value back to our data container singleton
    DataContainerSingleton.sharedDataContainer.someInt = Int(textField.text!)
    return true
  }

}

