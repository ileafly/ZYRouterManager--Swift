//
//  ZYRouterManager.swift
//  ZYRouterManager
//
//  Created by luzhiyong on 2018/9/12.
//  Copyright © 2018年 ilealfy. All rights reserved.
//

/*
 * ZYRouterManager
 * 路由层解决的核心问题就是原来界面或者组件之间互相调用都必须互相依赖，需要清楚目标对象的逻辑，而且OC版需要导入目标的头文件
 * 通过路由中间件中转，只需要依赖路由或某种通讯协议，路由的核心逻辑就是目标匹配
 * 对于调用者来说，只需要传入对于的URL或路由规则即可
 */

import UIKit

let RootScheme = "router" // 主scheme 所有的路由跳转都要遵循这个格式

enum RouterPath: String {
    case detailPath = "detail"
    case searchPath = "search"
}

class ZYRouterManager: NSObject {

    
    /// 路由中间件入口方法
    ///
    /// - Parameter schema: 需要跳转的scheme
    /// - Returns: 是否能跳转
    class func routerWithSchema(_ schema: String) -> Bool {
        guard schema.count > 0 else {
            return false
        }
        if let urlString = schema.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
                return ZYRouterManager.analysisScheme(url)
            }
        }
        
        return false
    }
    
    
    /// 分析传入的scheme
    ///
    /// - Parameter url: 跳转的URL对象
    /// - Returns: 是否能跳转
    private class func analysisScheme(_ url: URL) -> Bool {
        let routePattern = url.absoluteString
        if let components = URLComponents(string: routePattern), let scheme = components.scheme {
            
            guard scheme == RootScheme else {
                return false
            }
            
            let host = components.host
            
            var queryParams = Dictionary<String, Any>()
            
            if let queryItems = components.queryItems {
                for item in queryItems {
                    if item.value == nil {
                        continue
                    }
                    queryParams[item.name] = item.value
                }
            }
            
            switch host {
            case RouterPath.detailPath.rawValue:
                do {
                    // 跳转到详情页
                    let vc = DetailViewController()
                    let currentVC = ZYRouterManager.getCurrentVC()
                    if let productId = queryParams["productId"] as? String {
                        vc.productId = productId
                    }
                    currentVC?.navigationController?.pushViewController(vc, animated: true)
                }
                break
            case RouterPath.searchPath.rawValue:
                do {
                    // 跳转到搜索页
                    let vc = SearchViewController()
                    let currentVC = ZYRouterManager.getCurrentVC()
                    currentVC?.navigationController?.pushViewController(vc, animated: true)
                }
                break
            default: break
                
            }
        }
        return false
    }
    
    
    /// 获取当前控制器
    ///
    /// - Returns: 当前控制器
    private class func getCurrentVC() -> UIViewController? {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            return ZYRouterManager.findCurrentVC(rootVC)
        }
        return nil
    }
    
    /// 在rootVC中查找currentVC
    ///
    /// - Parameter parentVC: 父ViewController
    /// - Returns: 查找到的ViewController
    private class func findCurrentVC(_ parentVC: UIViewController) -> UIViewController? {
        if parentVC.isKind(of: UINavigationController.self), let nav = parentVC as? UINavigationController {
            // rootVC是UINavigationController
            if let vc = nav.childViewControllers.last {
              return ZYRouterManager.findCurrentVC(vc)
            }
            return nil
        } else if parentVC.isKind(of: UITabBarController.self), let tabBar = parentVC as? UITabBarController {
            // rootVC是UITabBarController
            if let vc = tabBar.selectedViewController {
                return ZYRouterManager.findCurrentVC(vc)
            }
            return nil
        } else if let presentedVC = parentVC.presentedViewController {
            return ZYRouterManager.findCurrentVC(presentedVC)
        }
        return parentVC
    }
    
}
