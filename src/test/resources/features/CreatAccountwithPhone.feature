@smoke
Feature: create account

  Background: 
    * def createAccount = callonce read('CreateAccount.feature')
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id
    Given url "https://tek-insurance-api.azurewebsites.net"
    And print createAccount

  Scenario: addin phone
    And path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer "+validToken
    And param primaryPersonId = createAccountId
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
    And assert response.phoneNumber == phoneNumber
