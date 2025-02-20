//
//  UIKit_TemplateTests.swift
//  UIKit-TemplateTests
//
//  Created by Sergiy on 2/10/25.
//

import Testing
import UIKit

@testable import UIKit_Template

struct UIKit_TemplateTests {

    @Test func example() {
      DispatchQueue.main.async {
        let coordinator = MainCoordinator(window: UIWindow())
        let viewModel: HomeViewModelProtocol = HomeViewModel(BaseRepository(), coordinator)
        
        #expect(viewModel.state == .idle)
      }
    }
}
