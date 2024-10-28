*** Settings ***
Documentation    Test the login functionality of the BestPick app.
Library          AppiumLibrary

 
*** Variables ***
${URL}                        http://127.0.0.1:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    15
${ANDROID_APP}                 C:\\Users\\User\\AndroidStudioProjects\\Bestpick_android\\app\\build\\outputs\\apk\\debug\\app-debug.apk
${APP_PACKAGE}                com.example.reviewhub
${VALID_EMAIL}                earthsrichok31@gmail.com    
${VALID_PASSWORD}             1234
${Searching}                  Nack
${Validsearching}             Ging

*** Test Cases ***
Search Test
    [Documentation]    Test valid search
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/searchEditText
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/search_edit_text    timeout=30s    
    Input Text         id=${APP_PACKAGE}:id/search_edit_text       Nack
    Click Element    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.example.reviewhub:id/recycler_view_search_results"]/android.widget.FrameLayout[1]
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/follower    timeout=30s
    Close Application

Search invalid Test
    [Documentation]    Test invalid   Search
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/searchEditText
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/search_edit_text    timeout=30s    
    Input Text         id=${APP_PACKAGE}:id/search_edit_text       Ging
    Close Application


*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s

Login 
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible    id=com.example.reviewhub:id/searchEditText    timeout=10s
