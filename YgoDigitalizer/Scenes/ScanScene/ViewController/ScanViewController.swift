//
//  ScanViewController.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 01/10/21.
//



import UIKit
import Vision

class ScanViewController: UIViewController {
    
    private lazy var rescanButton: UIButton = .init()
    private lazy var label: UILabel = .init()
    private lazy var imageView: UIImageView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()

        recognizeText(image: imageView.image)
    }

    private func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Request
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                return
            }

            var foundText: String = ""
            for recognized in observations {
                guard let text = recognized.topCandidates(1).first?.string else { return }
                
                let splittedText = text.components(separatedBy: " ")
                
                if text.count >= 10 && splittedText[0].isNumeric {
                    foundText = splittedText[0]
                }
                else {
                    print(text)
                }
            }
            DispatchQueue.main.async {
                self?.label.text = foundText
            }
        }
        
        // Process request
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    private func setupViews() {        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemGray2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Example3")
        imageView.contentMode = .scaleAspectFit
            
        rescanButton.translatesAutoresizingMaskIntoConstraints = false
        rescanButton.setTitle("Scan one more time", for: .normal)
        rescanButton.backgroundColor = .systemBlue
        rescanButton.setTitleColor(.white, for: .normal)
        rescanButton.layer.cornerRadius = 12
        rescanButton.addTarget(self, action: #selector(rescanTapped), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        view.addSubview(rescanButton)
        view.addSubview(label)
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        
        let rescanButtonConstraints = [
            rescanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rescanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            rescanButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            rescanButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(rescanButtonConstraints)
        
    }
    
    @objc private func rescanTapped() {
        activateCamera()
    }
}

extension ScanViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func activateCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        imageView.image = image
        recognizeText(image: image)
    }
}
