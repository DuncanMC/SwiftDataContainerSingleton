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
  
  override func viewWillAppear(animated: Bool)
  {
    textField.text =  "\(DataContainerSingleton.sharedDataContainer.someInt ?? 0)"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    textField.text =  "\(DataContainerSingleton.sharedDataContainer.someInt ?? 0)"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
  {
    textField.resignFirstResponder()
    return true;
  }
  
  func textFieldShouldEndEditing(textField: UITextField) -> Bool
  {
    DataContainerSingleton.sharedDataContainer.someInt = textField.text!.toInt()
    return true
  }
}
