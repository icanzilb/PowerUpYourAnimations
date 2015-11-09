//
//  LoginViewController.swift
//  Streamify
//
//  Created by Marin Todorov on 8/11/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var fldUsername: UITextField!
  @IBOutlet weak var fldPassword: UITextField!
  
  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var imgBackground: UIImageView!
  
  @IBAction func actionLogin(sender: AnyObject) {
    view.endEditing(true)
    
    UIView.animateAndChainWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {
      self.btnLogin.transform = CGAffineTransformConcat(
        CGAffineTransformMakeScale(0.85, 0.85),
        CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      )
      self.btnLogin.layer.cornerRadius = 0.0
      self.btnLogin.layer.borderWidth = 6.0

      }, completion: nil)
      
      .animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.33, initialSpringVelocity: 0.0, options: [], animations: {
        self.btnLogin.transform = CGAffineTransformConcat(
          CGAffineTransformMakeScale(1.33, 1.33),
          CGAffineTransformMakeRotation(0)
        )
        self.btnLogin.layer.cornerRadius = 40.0
        self.btnLogin.layer.borderWidth = 0.0

        }, completion: nil)
      
      .animateWithDuration(0.25, delay: 0.0, options: [.Repeat], animations: {
        self.btnLogin.alpha = 0.5
        }, completion: nil)


    
  }
  
  var didFade = false
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if !didFade {
      
      //tint animation
      
      
      didFade = true
    }
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    guard textField.text?.characters.count <= 5 else {
      //validation error
      textField.center.y += 1
      UIView.animateWithDuration(3.0, delay: 0.0,
        usingSpringWithDamping: 0.2, initialSpringVelocity: 250,
        options: .AllowUserInteraction,
        animations: {
          textField.center.y -= 1
        }, completion: nil)

      return false
    }
    return true
  }
}

// MARK: - Starter project code
extension LoginViewController: StarterProjectCode {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    btnLogin.layer.borderColor = UIColor(red: 20/255.0, green: 123/255.0, blue: 195/255.0, alpha: 1.0).CGColor
    btnLogin.layer.cornerRadius = 40
  }
  
  func finalAnimation() {
    
    //reset button
    UIView.animateAndChainWithDuration(0.33, delay: 0, options: [], animations: {
      self.btnLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
      }, completion: nil)
      .animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
        self.fldUsername.center.y -= self.view.bounds.height
        }, completion: nil)
      
      .animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
        self.fldPassword.center.y -= self.view.bounds.height
        }, completion: {_ in
          //push next screen
          self.showLoggedIn()
      })
  }
  
  func showLoggedIn() {
    let alert = UIAlertController(title: "Success!", message: "You have logged in", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Cool", style: .Default, handler: {_ in
      alert.dismissViewControllerAnimated(true, completion: nil)
      self.navigationController!.popViewControllerAnimated(true)
    }))
    presentViewController(alert, animated: true, completion: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    markAsSeen(self)
  }
}