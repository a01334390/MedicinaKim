/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import ResearchKit
import CareKit

class TabBarViewController: UITabBarController {
  fileprivate let carePlanStoreManager = CarePlanStoreManager.sharedCarePlanStoreManager
  fileprivate let carePlanData: CarePlanData
  fileprivate var symptomTrackerViewController: OCKSymptomTrackerViewController? = nil
  fileprivate var insightsViewController: OCKInsightsViewController? = nil
  fileprivate var insightChart: OCKBarChart? = nil
  
  required init?(coder aDecoder: NSCoder) {
    carePlanData = CarePlanData(carePlanStore: carePlanStoreManager.store)

    super.init(coder: aDecoder)

    carePlanStoreManager.delegate = self
    carePlanStoreManager.updateInsights()

    let careCardStack = createCareCardStack()
    let symptomTrackerStack = createSymptomTrackerStack()
    let insightsStack = createInsightsStack()
    let connectStack = createConnectStack()
    
    self.viewControllers = [careCardStack,
                            symptomTrackerStack,
                            insightsStack,
                            connectStack]
    
    tabBar.tintColor = UIColor.darkOrange()
    tabBar.barTintColor = UIColor.lightGreen()
  }
    
    override func viewDidAppear(_ animated: Bool) {
        menuOne()
        let alert = UIAlertController(title: "Ya termino el cuestionario", message: "Recuerda que es importante tener un seguimiento diario para saber cómo te encuentras y para que tu médico conozca tu progreso ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func menuOne(){
        // 1
        let optionMenu = UIAlertController(title: nil, message: "¿Cómo te sientes hoy?", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Feliz", style: .default, handler:{ (UIAlertAction) in self.menuTwo()
        })
        let saveAction = UIAlertAction(title: "Triste", style: .default, handler:{ (UIAlertAction) in self.menuTwo()
        })
        
        // 3
        let cancelAction = UIAlertAction(title: "Enojado", style: .default, handler:{ (UIAlertAction) in self.menuTwo()
        })
        let sucidideAction = UIAlertAction(title: "Suicida", style: .cancel, handler:{ (UIAlertAction) in self.menuTwo()
        })
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(sucidideAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func menuTwo(){
        // 1
        let optionMenu = UIAlertController(title: nil, message: "¿Ya te tomaste tu medicamento?", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Sí, ya me lo tome", style: .default, handler:{ (UIAlertAction) in self.menuThree()
        })
        let saveAction = UIAlertAction(title: "Estoy esperando para tomarla", style: .default, handler:{ (UIAlertAction) in self.menuThree()
        })
        
        // 3
        let cancelAction = UIAlertAction(title: "No, se me olvido", style: .default, handler:{ (UIAlertAction) in self.menuThree()
        })
        let sucidideAction = UIAlertAction(title: "No tomo medicamentos", style: .cancel, handler:{ (UIAlertAction) in self.menuThree()
        })
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(sucidideAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func menuThree(){
        // 1
        let optionMenu = UIAlertController(title: nil, message: "¿Cómo te sientes de energía?", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "muy activo ", style: .default)
        let saveAction = UIAlertAction(title: "activo", style: .default)
        
        // 3
        let cancelAction = UIAlertAction(title: "sin energía", style: .default)
        let sucidideAction = UIAlertAction(title: "exhausta", style: .cancel)
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(sucidideAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }

  fileprivate func createCareCardStack() -> UINavigationController {
    let viewController = OCKCareCardViewController(carePlanStore: carePlanStoreManager.store)
    viewController.maskImage = UIImage(named: "heart")
    viewController.smallMaskImage = UIImage(named: "small-heart")
    viewController.maskImageTintColor = UIColor.darkGreen()
    
    viewController.tabBarItem = UITabBarItem(title: "Plan médico", image: UIImage(named: "carecard"), selectedImage: UIImage(named: "carecard-filled"))
    viewController.title = "Plan médico"
    return UINavigationController(rootViewController: viewController)
  }
  
  fileprivate func createSymptomTrackerStack() -> UINavigationController {
    let viewController = OCKSymptomTrackerViewController(carePlanStore: carePlanStoreManager.store)
    viewController.delegate = self
    viewController.progressRingTintColor = UIColor.darkGreen()
    symptomTrackerViewController = viewController
    
    viewController.tabBarItem = UITabBarItem(title: "Symptom Tracker", image: UIImage(named: "symptoms"), selectedImage: UIImage.init(named: "symptoms-filled"))
    viewController.title = "Symptom Tracker"
    
    return UINavigationController(rootViewController: viewController)
  }
  
  fileprivate func createInsightsStack() -> UINavigationController {
    let viewController = OCKInsightsViewController(insightItems: [OCKInsightItem.emptyInsightsMessage()],
                                                   headerTitle: "Revisión", headerSubtitle: "")
    insightsViewController = viewController

    
    viewController.tabBarItem = UITabBarItem(title: "Insights", image: UIImage(named: "insights"), selectedImage: UIImage.init(named: "insights-filled"))
    viewController.title = "Insights"
    return UINavigationController(rootViewController: viewController)
  }
  
  fileprivate func createConnectStack() -> UINavigationController {
    let viewController = OCKConnectViewController(contacts: carePlanData.contacts)
    viewController.delegate = self
    
    viewController.tabBarItem = UITabBarItem(title: "Connect", image: UIImage(named: "connect"), selectedImage: UIImage.init(named: "connect-filled"))
    viewController.title = "Connect"
    return UINavigationController(rootViewController: viewController)
  }
}

// MARK: - OCKSymptomTrackerViewControllerDelegate
extension TabBarViewController: OCKSymptomTrackerViewControllerDelegate {
  func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController,
                                    didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
    guard let userInfo = assessmentEvent.activity.userInfo,
      let task: ORKTask = userInfo["ORKTask"] as? ORKTask else { return }
    
    let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
    taskViewController.delegate = self
    
    present(taskViewController, animated: true, completion: nil)
  }
}

// MARK: - ORKTaskViewControllerDelegate
extension TabBarViewController: ORKTaskViewControllerDelegate {
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith
    reason: ORKTaskViewControllerFinishReason, error: Error?) {

    defer {
      dismiss(animated: true, completion: nil)
    }
    
    guard reason == .completed else { return }
    guard let symptomTrackerViewController = symptomTrackerViewController,
      let event = symptomTrackerViewController.lastSelectedAssessmentEvent else { return }
    let carePlanResult = carePlanStoreManager.buildCarePlanResultFrom(taskResult: taskViewController.result)
    carePlanStoreManager.store.update(event, with: carePlanResult, state: .completed) {
      success, _, error in
      if !success {
        print(error?.localizedDescription)
      }
    }
  }
}

// MARK: - CarePlanStoreManagerDelegate
extension TabBarViewController: CarePlanStoreManagerDelegate {
  func carePlanStore(_ store: OCKCarePlanStore, didUpdateInsights insights: [OCKInsightItem]) {
    if let trainingPlan = (insights.filter { $0.title == "Plan médico" }.first) {
      insightChart = trainingPlan as? OCKBarChart
    }

    insightsViewController?.items = insights
  }
}

// MARK: - OCKConnectViewControllerDelegate
extension TabBarViewController: OCKConnectViewControllerDelegate {
  func connectViewController(_ connectViewController: OCKConnectViewController,
                             didSelectShareButtonFor contact: OCKContact,
                             presentationSourceView sourceView: UIView) {
    let document = carePlanData.generateDocumentWith(chart: insightChart)
    let activityViewController = UIActivityViewController(activityItems: [document.htmlContent],
                                                          applicationActivities: nil)
    
    present(activityViewController, animated: true, completion: nil)
  }
}
