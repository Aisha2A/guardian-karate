Feature: create account feature and adding information

  Background: 
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: create account
    And path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer "+validToken
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail();
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Ahmed",
      "lastName": "Obaid",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2002-08-06"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    And path "/api/accounts/add-account-car"
    And header Authorization = "Bearer "+validToken
    And param primaryPersonId = response.id
    And request
      """
      {
        "make": "Toyota",
        "model": "camry",
        "year": "2020",
        "licensePlate": "7789aa"
      }
      """
    When method post
    Then status 201
    And print response
    And path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer "+validToken
    And param primaryPersonId = response.id
    And request
      """
      {
      "phoneNumber": "7897897890",
      "phoneExtension": "3456",
      "phoneTime": "10:00",
      "phoneType": "iphone"
      }
      """
    When method post
    Then status 201
    And print response
    And path "/api/accounts/add-account-address"
    And header Authorization = "Bearer "+validToken
    And param primaryPersonId = response.id
    And request
      """
      {
      "addressType": "Apartment",
      "addressLine1": "5699 seminary road",
      "city": "Alexandria",
      "state": "Virginia",
      "postalCode": "78907",
      "countryCode": "00876"
      }
      """
    When method post
    Then status 201
    And print response
