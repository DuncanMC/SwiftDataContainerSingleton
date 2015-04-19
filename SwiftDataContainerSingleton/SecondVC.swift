//
//  SecondVC.swift
//  SwiftDataContainerSingleton
//
//  Created by Duncan Champney on 4/19/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit

class SecondVC: UIViewController, UITextFieldDelegate

{
  @IBOutlet weak var textField: UITextField!
  
  //-------------------------------------------------------------------------------------------------------
  // MARK: - UIViewController methods -
  //-------------------------------------------------------------------------------------------------------
  
  override func viewWillAppear(animated: Bool)
  {
    //Load the value "someInt" from our shared ata container singleton
    let value = DataContainerSingleton.sharedDataContainer.someInt ?? 0
    
    //Install the value into the text field.
    textField.text =  "\(value)"
  }

  //-------------------------------------------------------------------------------------------------------
  // MARK: - UITextFieldDelegate methods -
  //-------------------------------------------------------------------------------------------------------
  
  func textFieldShouldReturn(textField: UITextField) -> Bool
  {
    textField.resignFirstResponder()
    return true
  }
  
  //-------------------------------------------------------------------------------------------------------
  
  func textFieldShouldEndEditing(textField: UITextField) -> Bool
  {
    //Save the changed value back to our data container singleton
    DataContainerSingleton.sharedDataContainer.someInt = textField.text!.toInt()
    return true
  }
}
