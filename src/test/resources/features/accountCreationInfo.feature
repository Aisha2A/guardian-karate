Feature: create new account with adding Information

  Background: 
    * def result = callonce read('CreateAccount.feature')
    * def token = result.validToken
    * def createdId = result.response.id
    Given url "https://tek-insurance-api.azurewebsites.net"
    And print result

  Scenario: 
    And path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = createdId
    And request
      """
      {
        "addressType": "Apartment",
        "addressLine1": "56098 seminary road",
        "city": "Alexandria",
        "state": "Virginia",
        "postalCode": "78978",
        "countryCode": "0065",
        "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + token
    * def licenseData = Java.type('api.utility.data.GenerateData')
    * def licensePlate = licenseData.getLicense()
    And param primaryPersonId = createdId
    And request
      """
      {
      "make": "Toyota",
      "model": "camry",
      "year": "2010",
      "licensePlate": "#(licensePlate)"
      }
      """
    When method post
    Then status 201
    And print response
    And path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer "+ token
    And param primaryPersonId = createdId
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber();
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Evening",
      "phoneType": "Moblie"
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdId
    And header Authorization = "Bearer " +token
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
