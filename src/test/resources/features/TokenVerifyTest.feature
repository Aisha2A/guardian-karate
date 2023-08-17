@regression
Feature: token verify Feature

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Validate user with valid token
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response == "true"

  Scenario: Verify token with invalid username
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisorr"
    And param token = response.token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  Scenario: Verify token with invalid token
    Given path "/api/token/verify"
    And param username = "supervisorr"
    And param token = "wrong path"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"

  Scenario: existing primary person id
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/accounts/get-account"
    And header Authorization = "Bearer "+response.token
    And param primaryPersonId = "3423"
    When method get
    Then status 200
    And print response

  Scenario: primary person id that is not exist
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/accounts/get-account"
    And header Authorization = "Bearer "+response.token
    And param primaryPersonId = "99898423"
    When method get
    Then status 404
    And print response

  Scenario: Validate response JSON array and have 4 JSON object
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer "+response.token
    When method get
    Then status 200
    And print response

  Scenario: creating new account
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer "+response.token
    And request
      """
      {
      "email": "Afghanistan1238@tekschool.us",
      "firstName": "Aisha",
      "lastName": "Obaid",
      "title": "Mrs.",
      "gender": "FEMALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2000-08-06"
      }
      """
    When method post
    Then status 201
    And print response

  Scenario: deleting acount
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/accounts/delete-account"
    And header Authorization = "Bearer "+response.token
    And param primaryPersonId = "9635"
    When method delete
    Then status 200
    And print response

  Scenario: creating new account and adding car
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer "+response.token
    And request
      """
      {
      "email": "AfghanigirlAbb@tekschool.us",
      "firstName": "Aisha",
      "lastName": "Ahmed",
      "title": "Mrs.",
      "gender": "FEMALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2000-08-06"
      }
      """
    When method post
    Then status 201
    And print response
    And path "/api/accounts/add-account-car"
    And param primaryPersonId = response.id
    And request
      """
      {
        "make": "Toyota",
        "model": "venza",
        "year": "2023",
        "licensePlate": "AHHB217"
      }
      """
    When method post
    Then status 201
    And print response
