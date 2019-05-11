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

import CareKit

enum ActivityIdentifier: String {
  case cardio
  case limberUp = "Levantate"
  case targetPractice = "Medicamento"
  case pulse
  case temperature
}

class CarePlanData: NSObject {
  let carePlanStore: OCKCarePlanStore
  let contacts =
    [OCKContact(contactType: .personal,
                name: "Sumatta Reyna",
                relation: "Doctor",
                tintColor: nil,
                phoneNumber: CNPhoneNumber(stringValue: "888-555-5512"),
                messageNumber: CNPhoneNumber(stringValue: "888-555-5512"),
                emailAddress: "shaunofthedead@example.com",
                monogram: "SR",
                image: UIImage(named: "shaun-avatar")),
     OCKContact(contactType: .careTeam,
                name: "Columbus Ohio",
                relation: "Terapeuta",
                tintColor: nil,
                phoneNumber: CNPhoneNumber(stringValue: "888-555-5235"),
                messageNumber: CNPhoneNumber(stringValue: "888-555-5235"),
                emailAddress: "columbus@example.com",
                monogram: "CO",
                image: UIImage(named: "columbus-avatar")),
     OCKContact(contactType: .careTeam,
                name: "Dr Hershel Greene",
                relation: "Nutriologo",
                tintColor: nil,
                phoneNumber: CNPhoneNumber(stringValue: "888-555-2351"),
                messageNumber: CNPhoneNumber(stringValue: "888-555-2351"),
                emailAddress: "dr.hershel@example.com",
                monogram: "HG",
                image: UIImage(named: "hershel-avatar"))]

  class func dailyScheduleRepeating(occurencesPerDay: UInt) -> OCKCareSchedule {
    return OCKCareSchedule.dailySchedule(withStartDate: DateComponents.firstDateOfCurrentWeek,
                                         occurrencesPerDay: occurencesPerDay)
  }

  init(carePlanStore: OCKCarePlanStore) {
    self.carePlanStore = carePlanStore
    
    let cardioActivity = OCKCarePlanActivity(
      identifier: ActivityIdentifier.cardio.rawValue,
      groupIdentifier: nil,
      type: .intervention,
      title: "Cardio",
      text: "60 Minutes",
      tintColor: UIColor.darkOrange(),
      instructions: "Corre a paso moderado por al menos 1h al día.",
      imageURL: nil,
      schedule:CarePlanData.dailyScheduleRepeating(occurencesPerDay: 2),
      resultResettable: true,
      userInfo: nil)
    
    let limberUpActivity = OCKCarePlanActivity(
      identifier: ActivityIdentifier.limberUp.rawValue,
      groupIdentifier: nil,
      type: .intervention,
      title: "Levantate",
      text: "Levantate regularmente",
      tintColor: UIColor.darkOrange(),
      instructions: "Es importante levantarte y estirarte un poco para calentarl os músculos en tus brazos, piernas y espalda.",
      imageURL: nil,
      schedule: CarePlanData.dailyScheduleRepeating(occurencesPerDay: 6),
      resultResettable: true,
      userInfo: nil)
    
    let targetPracticeActivity = OCKCarePlanActivity(
      identifier: ActivityIdentifier.targetPractice.rawValue,
      groupIdentifier: nil,
      type: .intervention,
      title: "Medicamento",
      text: nil,
      tintColor: UIColor.darkOrange(),
      instructions: "Debes consumir tus 4 medicamentos del día. ",
      imageURL: nil,
      schedule: CarePlanData.dailyScheduleRepeating(occurencesPerDay: 2),
      resultResettable: true,
      userInfo: nil)
    
    let pulseActivity = OCKCarePlanActivity
      .assessment(withIdentifier: ActivityIdentifier.pulse.rawValue,
                  groupIdentifier: nil,
                  title: "Hola",
                  text: "Do you have one?",
                  tintColor: UIColor.darkGreen(),
                  resultResettable: true,
                  schedule: CarePlanData.dailyScheduleRepeating(occurencesPerDay: 1),
                  userInfo: ["ORKTask": AssessmentTaskFactory.makePulseAssessmentTask()])
    
    let temperatureActivity = OCKCarePlanActivity
      .assessment(withIdentifier: ActivityIdentifier.temperature.rawValue,
                  groupIdentifier: nil,
                  title: "Temperature",
                  text: "Oral",
                  tintColor: UIColor.darkYellow(),
                  resultResettable: true,
                  schedule: CarePlanData.dailyScheduleRepeating(occurencesPerDay: 1),
                  userInfo: ["ORKTask": AssessmentTaskFactory.makeTemperatureAssessmentTask()])

    
    super.init()
    
    for activity in [cardioActivity, limberUpActivity, targetPracticeActivity,
                     pulseActivity, temperatureActivity] {
                      add(activity: activity)
    }
  }
  
  func add(activity: OCKCarePlanActivity) {
    carePlanStore.activity(forIdentifier: activity.identifier) {
      [weak self] (success, fetchedActivity, error) in
      guard success else { return }
      guard let strongSelf = self else { return }

      if let _ = fetchedActivity { return }
      
        strongSelf.carePlanStore.add(activity, completion: { _,_  in })
    }
  }
}

extension CarePlanData {
  func generateDocumentWith(chart: OCKChart?) -> OCKDocument {
    let intro = OCKDocumentElementParagraph(content: "He estado midiendo mis esfuerzos con esta aplicación y me gustaría que lo vieras.")
    
    var documentElements: [OCKDocumentElement] = [intro]
    if let chart = chart {
      documentElements.append(OCKDocumentElementChart(chart: chart))
    }
    
    let document = OCKDocument(title: "Re: Reporte semanal", elements: documentElements)
    document.pageHeader = "Reporte semanal"
    
    return document
  }
}
