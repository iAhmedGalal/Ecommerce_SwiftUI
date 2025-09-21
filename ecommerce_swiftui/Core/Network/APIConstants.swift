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
    static let myNotifications              = "get-my-notification"
    static let readNotifications            = "notifications/%@/read"
    static let countNotifications           = "notifications/count"
    static let DELETE_ACCOUNT_ENDPOINT      = "clients/remove-account"
    static let login                        = "clients/login"
    static let signup                       = "clients/create"
    static let emailCode                    = "email-code"
    static let editProfile                  = "profile"
    static let activateCode                 = "clients/active"
    static let anotherActivate              = "clients/request-code"
    static let productsList                 = "cat-items/%@"
    static let countryList                  = "provinces"
    static let cityList                     = "provinces/%@"
    static let newOrder                     = "orders/new"
    static let aboutUsURL                   = "about-us"
    static let termsOfUseURL                = "terms-of-use"
    static let callUsURL                    = "contact-us"
    static let chatURL                      = "chat"
    static let addFavorite                  = "clients/add-to-favorites"
    static let getFavorite                  = "clients/get-client-favorites"
    static let removeFavorite               = "clients/remove-from-favorites"
    static let userProfileURL               = "clients/profile"
    static let userOrdersURL                = "requests"

    static let discountOffers               = "discount-offers"
    static let itemOffers                   = "offers"
    static let offerDetails                 = "offer/%@"

    static let slider                       = "sliders"
    static let discountsList                = "offer-items"
    static let mostOrderList                = "most-ordered-items"
    static let recentlyAddList              = "latest-items"
    static let companyList                  = "companies"
    static let companyItems                 = "companies/%@/items"
    static let categoryList                 = "cats"
    static let subCategoryList              = "cats/%@"
    static let itemDetails                  = "items/%@"
    static let itemProperties               = "item/properties"
    static let search                       = "search"

    static let requestSettings              = "request-settings"
    static let requests                     = "requests"
    static let cancelRequest                = "request-cancel"
    static let requestDetails               = "request-details/%@"
    static let regionsList                  = "get-regions"
    static let cityRegionList               = "get-region-cities?region_id=%@"
    static let request_image                = "orders/request-img"
    static let payFortOrder                 = "stand-alone"
    static let payFortData                  = "badrshop/tools/save-bill-native-mobile?order_id=%@"
    static let resetPassword                = "reset-password"
    static let checkCoupon                  = "check-coupon"
    static let rate                         = "users/rate-item"
    static let allPages                     = "pages"
    static let page                         = "page/%@"
    static let clientData                   = "client-data"
    static let distancePrice                = "get_distance_price"
    static let getItemPrices                = "items/prices"
    static let editOrder                    = "edit-order/%@"
}
