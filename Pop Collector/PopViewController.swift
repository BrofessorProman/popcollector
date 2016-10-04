//
//  PopViewController.swift
//  Pop Collector
//
//  Created by Colton Boeckman on 10/3/16.
//  Copyright © 2016 Colton Boeckman. All rights reserved.
//

import UIKit

class PopViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addupdateButton: UIButton!
    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var pop : Pop? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if pop != nil {
            popImageView.image = UIImage(data: pop!.image as! Data)
            titleTextField.text! = pop!.title!
            print("We have a game!")
            addupdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        popImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        if pop != nil {
            pop!.title = titleTextField.text!
            pop!.image = UIImagePNGRepresentation(popImageView.image!) as NSData?
            
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let popVynal = Pop(context: context)
            popVynal.title = titleTextField.text!
            popVynal.image = UIImagePNGRepresentation(popImageView.image!) as NSData?
        }
        
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(pop!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
