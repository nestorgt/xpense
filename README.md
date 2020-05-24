## Requirements
* Xcode 11.4.1
* iOS 12+

## Xcode configuration
* Page guide column at 120
* Tab With: 4 spaces
* Indent Width: 4 spaces

## Stack

* Architecture MVVM.
* Database is invisible to VM's, inmutable structs are used as models across all the app.

## Testing data
* Default categories are added on `CategoryService`
* Some transactions for testing are added on `TransactionService` (only on DEBUG mode)

## Currency Layer API

Due to a limitation on the free accounts:
```
{
    "success": false,
    "error": {
        "code": 105,
        "info": "Access Restricted - Your current Subscription Plan does not support HTTPS Encryption."
    }
}
```
and a limitation on the convert endpoint
```{
    "success": false,
    "error": {
        "code": 105,
        "info": "Access Restricted - Your current Subscription Plan does not support this API Function."
    }
}
```
An upgraded version of the API is being used.

## Improvements

* Add database error propagation to show error feedback
* Would favor the usage of a more FPR aproach, however without Combine it would require adding a 3rd party library (RxSwift or ReactiveSwift)
* Fetching transactions could be done per page (or per dar/month) if the number of transactions is too big
