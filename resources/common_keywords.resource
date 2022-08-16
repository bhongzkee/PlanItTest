*** Settings ***
Documentation     A test suite with a single test for valid login.
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Resource    common_constants.resource

*** Keywords ***
User Navigates To URL
    [Arguments]    ${p_url}
    Open Browser   ${BASE_URL}   ${BROWSER}
    Go To    ${p_url}
    Set Selenium Speed	0.25 seconds

User Clicks On Nav Header Text Link
    [Arguments]    ${p_text}
    ${t_locator} =    Set Variable   //div[contains(@class, "navbar")]//a[contains(text(), "${p_text}")]
    Wait Until Element Is Visible    ${t_locator}    10s
    Click Element    ${t_locator}

User Inputs Text On Field
    [Arguments]    ${p_fieldName}    ${p_text}
    ${t_locator} =    Set Variable   //div[label[contains(text(), "${p_fieldName}")]]//input | //div[label[contains(text(), "${p_fieldName}")]]//textarea
    Wait Until Element Is Visible    ${t_locator}    10s
    Input Text    ${t_locator}    ${p_text}    

User Clicks On Button
    [Arguments]    ${p_button}
    ${t_locator} =    Set Variable   //*[contains(@class,"btn")][contains(text(), "${p_button}")]
    Wait Until Element Is Visible    ${t_locator}    10s
    Click Element    ${t_locator}    

Field Error Message Should Be Visible
    [Arguments]    ${p_fieldName}    ${p_errorMessage}
    ${t_locator} =    Set Variable   //div[label[contains(text(), "${p_fieldName}")]]//*[contains(text(), "${p_errorMessage}")]
    Wait Until Element Is Visible    ${t_locator}    10s

Field Error Message Should Not Be Visible
    [Arguments]    ${p_fieldName}    ${p_errorMessage}
    ${t_locator} =    Set Variable   //div[label[contains(text(), "${p_fieldName}")]]//*[contains(text(), "${p_errorMessage}")]
    Wait Until Element Is Not Visible    ${t_locator}    10s
