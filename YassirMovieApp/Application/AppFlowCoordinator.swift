import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // uncomment this line to show UIKit screens
//        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
//        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
//        flow.start()

        
        // uncomment this line to show SwiftUI screens
        let moviesSwiftUISceneDIContainer = appDIContainer.makeMoviesSwiftUISceneDIContainer()
        let flow = moviesSwiftUISceneDIContainer.makeMoviesSwiftUISearchFlowCoordinator(navigationController: navigationController)
        flow.start()
        
    }
}
