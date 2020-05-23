## Requirements
* Xcode 11.4.1
* iOS 12+

## Xcode configuration
* Page guide column at 120
* Tab With: 4 spaces
* Indent Width: 4 spaces

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

- Add database error propagation to show error feedback
