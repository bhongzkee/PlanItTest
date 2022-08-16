*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Default Tags      ASSESSMENT
Resource          ../resources/common_keywords.resource
Test Teardown     Close Browser

*** Test Cases ***
Test Case 1
    User Navigates To URL    ${BASE_URL}
    User Clicks On Nav Header Text Link    Contact
    User Clicks On Button   Submit
    Field Error Message Should Be Visible    Forename    Forename is required
    Field Error Message Should Be Visible    Email    Email is required
    Field Error Message Should Be Visible    Message    Message is required

    User Inputs Text On Field    Forename    test name
    Field Error Message Should Not Be Visible    Forename    Forename is required
    User Inputs Text On Field    Email    testemail@mail.com
    Field Error Message Should Not Be Visible    Email    Email is required
    User Inputs Text On Field    Message    test mesaage
    Field Error Message Should Not Be Visible    Message    Message is required


Test Case 2
    User Navigates To URL    ${BASE_URL}
    User Clicks On Nav Header Text Link    Contact
    User Inputs Text On Field    Forename    Bhong
    User Inputs Text On Field    Surname    Dela Cruz
    User Inputs Text On Field    Email    testemail@mail.com
    User Inputs Text On Field    Telephone    1234567890
    User Inputs Text On Field    Message    test mesaage
    User Clicks On Button   Submit
    Wait Until Page Contains    Thanks Bhong, we appreciate your feedback.    30s


Test Case 3
    User Navigates To URL    ${BASE_URL}
    User Clicks On Nav Header Text Link    Home
    User Clicks On Button   Start Shopping
    User Clicks On Item Buy Button    Funny Cow    2
    User Clicks On Item Buy Button    Fluffy Bunny    1
    User Clicks On Nav Header Text Link    Cart
    The Item Quantity Should Be    Funny Cow    2
    The Item Quantity Should Be    Fluffy Bunny    1

