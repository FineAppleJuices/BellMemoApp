//
//  SceneDelegate.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //ios는 윈도우가 한개임 . 아래가 그 윈도우야
    var window: UIWindow?

//스토리보드를 지워버려서 어떻게 윈도우를 구성할지 알려줘야해. 그게 바로 아래 코드.
    //앱델리에 씬델리 연결하기전에 윈도우 구성을 어떻게 할거냐
    //아래 화면에서 시작함
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        //어느 컨트롤러로 시작할거냐
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // 네비게이션 컨트롤러를 윈도우의 루트로 설정
        window?.rootViewController = navigationController
        //root 붙어있으면 무조건 시작점
        window?.makeKeyAndVisible()
        //윈도우를 보이는 상태로 구성해줘
    }
    
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

