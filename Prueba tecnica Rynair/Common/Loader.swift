//
//  Loader.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 31/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

protocol Loader {
    func showLoader()
    func dismissLoader()
}

private struct AssociatedKeys {
    static var loader: UInt8 = 0
}

extension Loader where Self: UIViewController {
    var loaderView: LoaderViewController {
        get {
            guard let loader = objc_getAssociatedObject(self, &AssociatedKeys.loader) as? LoaderViewController else {
                let newLoader = LoaderViewController(parentController: self)
                self.loaderView = newLoader
                return newLoader
            }
            return loader
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.loader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoader() {
        loaderView.showLoader()
    }
    
    func dismissLoader() {
        loaderView.hideLoader()
    }
}

class LoaderViewController: UIViewController {
    
    weak var parentController: UIViewController?
    public init(parentController: UIViewController?) {
        self.parentController = parentController
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    public func showLoader() {
        guard let parentView = parentController?.view else { return }
        
        parentController?.addChild(self)
        parentView.addSubview(self.view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            parentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            parentView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            parentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        self.didMove(toParent: parentController)
    }
    
    public func hideLoader() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
