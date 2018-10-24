//
//  RegisterScreenViewViewController.swift
//  Seebo Project 
//
//  Created by Admin on 10/18/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class RegisterScreenViewController: UIViewController,RegisterViewProtocol{

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullNameError: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmPassError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    var presenter:RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterPresenter(RegView: self)
        configureTextFields()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        fullName.configure()
        fullName.textFieldWithIcon(image: #imageLiteral(resourceName: "name_icon"))
        email.configure()
        email.textFieldWithIcon(image: #imageLiteral(resourceName: "email_icon"))
        password.configure()
        password.textFieldWithIcon(image: #imageLiteral(resourceName: "lock_icon"))
        confirmPassword.configure()
        confirmPassword.textFieldWithIcon(image: #imageLiteral(resourceName: "lock_icon"))
        phone.configure()
        phone.textFieldWithIcon(image: #imageLiteral(resourceName: "name_icon"))
    }

    @IBAction func loginTab(_ sender: UIButton) {
         navigationController?.popViewController(animated: true)
    }
    @IBAction func signUP(_ sender: UIButton) {
        if (fullName.text?.isEmpty)! {
            fullNameError.alpha = 1
        }else if (!Helper.isValidEmail(emailStr: email.text!)) {
            emailError.alpha = 1
           // Alert.alert(view: self, title: "Invalid", message: "Please Enter Correct Email")
        }else if (!Helper.isValidPassword(paswordStr: password.text!)){
            passwordError.alpha = 1
        }else if (!Helper.isValidPassword(paswordStr: confirmPassword.text!)){
           confirmPassError.alpha = 1
        }else if (phone.text?.isEmpty)!{
           phoneError.alpha = 1
        }else{
            presenter.registerRequest(fullname: fullName.text!, email: email.text!, password: password.text!, repassword: confirmPassword.text!, phone:phone.text!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configureTextFields(){
        fullName.addTarget(self, action:"fullNameChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        email.addTarget(self, action:"emailChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        password.addTarget(self, action:"passwordChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        confirmPassword.addTarget(self, action:"confirmPasswordChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        phone.addTarget(self, action:"phoneChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
    }
   @objc func fullNameChange(){
        fullNameError.alpha = 0
        fullNameLabel.alpha = 0.7
        emailLabel.alpha = 0
        passwordLabel.alpha = 0
        confirmPasswordLabel.alpha = 0
        phoneLabel.alpha = 0
    }
    @objc func emailChange(){
        emailError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0.7
        passwordLabel.alpha = 0
        confirmPasswordLabel.alpha = 0
        phoneLabel.alpha = 0
    }
    @objc func passwordChange(){
        passwordError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0
        passwordLabel.alpha = 0.7
        confirmPasswordLabel.alpha = 0
        phoneLabel.alpha = 0
    }
    @objc func confirmPasswordChange(){
        confirmPassError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0
        passwordLabel.alpha = 0
        confirmPasswordLabel.alpha = 0.7
        phoneLabel.alpha = 0
    }
    @objc func phoneChange(){
        phoneError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0
        passwordLabel.alpha = 0
        confirmPasswordLabel.alpha = 0
        phoneLabel.alpha = 0.7
    }
    func showAlertMessage (message:String){
        Alert.alert(view: self, title: "Invalid", message: message)
    }
    func showToastMessage(message:String){
        ToastView.showToast(message: message, view: self.view)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let termsController = mainStoryboard.instantiateViewController(withIdentifier: "terms") as! TermsViewController
        navigationController?.pushViewController(termsController, animated: true)
    }
}
