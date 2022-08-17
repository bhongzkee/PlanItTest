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

User Clicks On Item Buy Button
    [Arguments]    ${p_itemName}   ${p_times}=1
    ${t_locator} =    Set Variable   //div[h4[contains(text(), "${p_itemName}")]]//a[contains(text(), "Buy")]
    Wait Until Element Is Visible    ${t_locator}    10s
    Repeat Keyword	${p_times}    Click Element    ${t_locator}    

Field Error Message Should Be Visible
    [Arguments]    ${p_fieldName}    ${p_errorMessage}
    ${t_locator} =    Set Variable   //div[label[contains(text(), "${p_fieldName}")]]//*[contains(text(), "${p_errorMessage}")]
    Wait Until Element Is Visible    ${t_locator}    10s

Field Error Message Should Not Be Visible
    [Arguments]    ${p_fieldName}    ${p_errorMessage}
    ${t_locator} =    Set Variable   //div[label[contains(text(), "${p_fieldName}")]]//*[contains(text(), "${p_errorMessage}")]
    Wait Until Element Is Not Visible    ${t_locator}    10s

The Item Quantity Should Be
    [Arguments]    ${p_itemName}    ${p_quantity}
    ${t_locator} =    Set Variable   //tr[contains(string(), "${p_itemName}")]//input[@value=${p_quantity}]
    Wait Until Element Is Visible    ${t_locator}    10s

Get Product Price
    [Arguments]    ${p_itemName}

    # get price column index
    ${elementCount} =    Get Element Count    //thead/tr[contains(string(), "Price")]/th
    FOR    ${i}    IN RANGE    ${elementCount}
        ${index} =    Evaluate    ${i}+1
        Log    ${index}
        ${text} =    Get Text    //thead/tr[contains(string(), "Price")]/th[${index}]
        Exit For Loop IF    "${text}" == "Price"
    END

    # get item price
    ${t_locator} =    Set Variable   //tr[contains(string(), "${p_itemName}")]/td[${index}]
    ${t_price} =    Get Text    ${t_locator}
    ${t_price} =	Fetch From Right	${t_price}    $	
    [return]  ${t_price}

Get Total Price
    ${t_locator} =    Set Variable   //tr[contains(string(), "Total:")]/td[1]
    ${t_price} =    Get Text    ${t_locator}
    ${t_price} =	Fetch From Right	${t_price}    Total: 
    [return]  ${t_price}
