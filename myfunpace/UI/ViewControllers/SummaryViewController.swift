//
//  ViewController.swift
//  myfunpace
//
//  Created by Nick Coelius on 10/26/24.
//

import UIKit

class ViewController: UIViewController {

    let viewModel: SummaryViewModel
    init() {
        viewModel = SummaryViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        viewModel.viewDidLoad()
    }


}

