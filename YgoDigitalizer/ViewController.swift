//
//  ViewController.swift
//  YuGiOhVirtualizer
//
//  Created by Bruno Thuma on 27/09/21.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemGray2
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Example1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
                if text.count == 10 && text.contains("-") {
                    foundText = text
                    print(text)
                }
                
            }
            
//            let text = observations.compactMap({
//                $0.topCandidates(1).first?.string
//            }).joined(separator: "; ")

            
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
            label.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }
}

