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
${validName}                      Bestpick01
${invalidName}                      
${BIO}                        Bestpick is best


*** Test Cases ***
Valid edit post 
    [Documentation]    Test valid Edit post 
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/profile
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/edit_profile_button    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/edit_profile_button
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/username_edit    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/editImg
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Pictures"]    timeout=30s
    Click Element    xpath=//android.widget.TextView[@text="Pictures"]
    Wait Until Element Is Visible    xpath=(//android.widget.ImageView)[1]    timeout=30s
    Click Element    xpath=(//android.widget.ImageView)[1]
    Wait Until Element Is Visible     id=${APP_PACKAGE}:id/username_edit    timeout=30s
    Input Text     id=${APP_PACKAGE}:id/username_edit        ${validName} 
    Input Text     id=${APP_PACKAGE}:id/bio_edit        ${BIO} 
    Click Element    id=${APP_PACKAGE}:id/editTextBirthday
    Wait Until Element Is Visible    id=android:id/datePicker    timeout=30s
    Click Element    xpath=//*[@content-desc="01 October 2024"]
    Wait Until Element Is Visible    id=android:id/button1    timeout=10s
    Click Element    id=android:id/button1
    Click Element    id=com.example.reviewhub:id/gender_spinner
    Wait Until Element Is Visible    xpath=//android.widget.CheckedTextView[@text="Female"]    timeout=5s
    Click Element                    xpath=//android.widget.CheckedTextView[@text="Female"]
    Click Element     id=${APP_PACKAGE}:id/save_button
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/edit_profile_button    timeout=30s
    Close Application

Valid edit post
    [Documentation]    Test upload photo 
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/profile
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/edit_profile_button    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/edit_profile_button
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/username_edit    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/editImg
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Pictures"]    timeout=30s
    Click Element    xpath=//android.widget.TextView[@text="Pictures"]
    Wait Until Element Is Visible    xpath=(//android.widget.ImageView)[1]    timeout=30s
    Click Element    xpath=(//android.widget.ImageView)[1]
    Wait Until Element Is Visible     id=${APP_PACKAGE}:id/username_edit    timeout=30s
    Close Application

Invalid edit post 
    [Documentation]    Test invalid edit post
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/profile
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/edit_profile_button    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/edit_profile_button
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/username_edit    timeout=30s
    Input Text     id=${APP_PACKAGE}:id/username_edit        ${invalidName}
    Click Element     id=${APP_PACKAGE}:id/save_button
    Wait Until Element Is Visible   xpath=//*[contains(@text, '')]    timeout=30s
    Close Application
    


*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s

Login 
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible    id=${APP_PACKAGE}:id/home   timeout=10s

