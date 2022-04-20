//
//  PaymentHandler.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/20/22.
//

import Foundation

import PassKit

typealias PaymentCompletitionHandler = (Bool) -> Void


class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSumaryItem = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletitionHandler?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard
            
    ]
    
    func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd = shippingEnd, let shippingStart = shippingStart {
            let startComponets = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponets = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponets, end: endComponets)
            shippingDelivery.detail = "Order delivered to your address"
            shippingDelivery.identifier = "DELIVERY"
            
            return [shippingDelivery]
            
        }
        
        return []
    }
    
    func startPayment(products: [Product], total: Float, completion: @escaping PaymentCompletitionHandler){
        completionHandler = completion
        
        paymentSumaryItem = []
        
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price).00"), type: .final)
            paymentSumaryItem.append(item)
        }
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
        paymentSumaryItem.append(total)
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSumaryItem
        paymentRequest.merchantIdentifier = "merchant.io.teamd.millenniumtechnologies"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Presented payment controller")
            }  else {
                debugPrint("Failed to present payment controller")
            }
        })
        
    }

}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }

       
    
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss{
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionhandler = self.completionHandler{
                        completionhandler(true)
                    }
                }else{
                    if let completionHandler = self.completionHandler {
                        completionHandler(false)
                    }
                }
            }
        }
      
    }
}
