//
//  ViewController.swift
//  TakePhoto
//
//  Created by Juan Morillo on 11/9/16.
//  Copyright © 2016 JuanMorillios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Creamos una variable es una clase que manejaremos la vista para la camara y la libreria
    let imagePickerController : UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var imageContainer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //idicamos que este imagePicker va a responder a este delegado
        imagePickerController.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressBtnMakePhoto(_ sender: AnyObject) {
        //Confirmamo si hay una camara disponible, para que no de error si no hay camara
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //Utilizamos para usar la camara de atrás
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
        
            //permitir edicion de la imagen en una vez seleccione la imagen, la pongo a nula
            imagePickerController.allowsEditing = false
            
            //Fuente de donde viene la foto
            imagePickerController.sourceType = .camera
            //Aqui decidimos si vamos a capturar una imagen o una foto
            imagePickerController.cameraCaptureMode = .photo
        
            //Presentamos la acción a la imagen.
            present(imagePickerController, animated: true, completion: nil)
            
            //para ver el resultado hay que realizar la prueba en un iphone, en el simulador no puede funcionará
        
            } else {
        
            //No hay camara, en caso de que el dispositivo no tenga camara
                
        }
        
    }
        
}

    @IBAction func pressBtnChangePhoto(_ sender: AnyObject) {
        //Seleccionamo una imagen de la libreria
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //permitir edicion de la imagen en una vez seleccione la imagen, la pongo a nula
            imagePickerController.allowsEditing = false
            //Fuente de donde viene la foto
            imagePickerController.sourceType = .photoLibrary
            //Presentamos la acción a la imagen.
            present(imagePickerController, animated: true, completion: nil)
       
    }

}
  //Con este metodo vamos a elegir que hacer con la foto tomada, utilizaremos delegados, viene definido por apple
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //Declaramos la imagen seleccionada, tambien realizamos un casting ya que lo que esta devolviendo es un diccionario y lo debemos convertir en imagen
        
        if let imagenSelected: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            //una vez que tenemos la imagen la asignamos
            imageContainer.image = imagenSelected
            
            //Creamos este if, para evitar la duplicidad de guardar la foto en la libreria
            if imagePickerController.sourceType == .camera {
            //Guardamos en la libreria del iphone
            UIImageWriteToSavedPhotosAlbum(imagenSelected, nil, nil, nil)
            
            }
            
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
        
    }
    

}
