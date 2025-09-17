//
//  Apistatic letants.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import UIKit

/*  -------------- Live ---------
 let SHOP_ID = 32879
 let basic = "https://jadallahtrading.com/"
 let mainUrl = basic + "mobile-apps/api/v2/" + "\(SHOP_ID)"
*/

/*   -------------- test --------- */
let SHOP_ID = 41478
let basic = "https://alraaeitrade.com/"
let mainUrl = basic + "mobile-apps/api/v10/" + "\(SHOP_ID)/"
let envType = "test"

enum Urls {
    static let LOGOUT                       = "logout"
    static let myNotifications              = "get-my-notification?api_token=%@"
    static let readNotifications            = "notifications/%@/read?api_token=%@"
    static let countNotifications           = "notifications/count?api_token=%@"
    static let DELETE_ACCOUNT_ENDPOINT      = "clients/remove-account?api_token=%@"
    static let login                        = "clients/login"
    static let signup                       = "clients/create"
    static let emailCode                    = "email-code"
    static let editProfile                  = "profile?api_token=%@"
    static let activateCode                 = "clients/active?api_token=%@"
    static let anotherActivate              = "clients/request-code?api_token=%@"
    static let productsList                 = "cat-items%@?api_token=%@"
    static let countryList                  = "provinces"
    static let cityList                     = "provinces/%@"
    static let newOrder                     = "orders/new?api_token=%@"
    static let aboutUsURL                   = "about-us"
    static let termsOfUseURL                = "terms-of-use"
    static let callUsURL                    = "contact-us"
    static let chatURL                      = "chat"
    static let addFavorite                  = "clients/add-to-favorites?api_token=%@"
    static let getFavorite                  = "clients/get-client-favorites?api_token=%@"
    static let removeFavorite               = "clients/remove-from-favorites?api_token=%@"
    static let userProfileURL               = "clients/profile?api_token=%@"
    static let userOrdersURL                = "requests?api_token=%@"

    static let discountOffers               = "discount-offers"
    static let itemOffers                   = "offers"
    static let offerDetails                 = "offer/%@?api_token=%@"

    static let slider                       = "sliders"
    static let discountsList                = "offer-items?api_token=%@"
    static let mostOrderList                = "most-ordered-items?api_token=%@"
    static let recentlyAddList              = "latest-items?api_token=%@"
    static let companyList                  = "companies"
    static let companyItems                 = "companies/%@/items?api_token=%@"
    static let categoryList                 = "cats"
    static let subCategoryList              = "cats/%@"
    static let itemDetails                  = "items/%@?api_token=%@"
    static let itemProperties               = "item/properties?api_token=%@"
    static let search                       = "search?api_token=%@"

    static let requestSettings              = "request-settings"
    static let requests                     = "requests?api_token=%@"
    static let cancelRequest                = "request-cancel?api_token=%@"
    static let requestDetails               = "request-details%@?api_token=%@"
    static let regionsList                  = "get-regions"
    static let cityRegionList               = "get-region-cities?region_id=%@"
    static let request_image                = "orders/request-img"
    static let payFortOrder                 = "stand-alone?api_token=%@"
    static let payFortData                  = "badrshop/tools/save-bill-native-mobile?order_id=%@"
    static let resetPassword                = "reset-password"
    static let checkCoupon                  = "check-coupon?api_token=%@"
    static let rate                         = "users/rate-item"
    static let allPages                     = "pages"
    static let page                         = "page/%@"
    static let clientData                   = "client-data?api_token=%@"
    static let distancePrice                = "get_distance_price"
    static let getItemPrices                = "items/prices?api_token=%@"
    static let editOrder                    = "edit-order/%@?api_token=%@"
}
