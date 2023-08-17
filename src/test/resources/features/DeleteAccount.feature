@regression
Feature: Delete account with exist id and with no id exist

  Background: 
    * def createAccount = callonce read('CreateAccount.feature')
    * def validToken = createAccount.validToken
    * def createAccountId = createAccount.response.id
    Given url "https://tek-insurance-api.azurewebsites.net"
    And print createAccount
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: delete account
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " +validToken
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"

  Scenario: delete account with no id exist
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " +validToken
    When method delete
    Then status 404
    And print response
