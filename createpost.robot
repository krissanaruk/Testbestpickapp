*** Settings ***
Documentation    Test the login functionality of the BestPick app.
Library          AppiumLibrary

 
*** Variables ***
${URL}                        http://127.0.0.1:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    15
${ANDROID_APP}                  C:\\Users\\earth\\AndroidStudioProjects\\ReviewHub_android\\app\\build\\outputs\\apk\\debug\\app-debug.apk
${APP_PACKAGE}                com.example.reviewhub
${VALID_EMAIL}                earthsrichok31@gmail.com    
${VALID_PASSWORD}             bestpick7890
${title}                      Notebook 
${Detail}                     spec GTX 8080 ราคา 500 บาท
${product name}               Notebook hp1234
${notify}                     กรุณา

*** Test Cases ***
Valid create post  
    [Documentation]    Test valid create post
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/add
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/menuhome    timeout=30s
    Input Text     id=${APP_PACKAGE}:id/TitleEditText    ${title}
    Input Text     id=${APP_PACKAGE}:id/contentEditText    ${Detail}
    Click Element    id=${APP_PACKAGE}:id/categorySpinner
    Wait Until Element Is Visible    xpath=//android.widget.CheckedTextView[@text='Laptop']     timeout=30s
    Click Element    xpath=//android.widget.CheckedTextView[@text='Laptop']
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/menuhome    timeout=30s
    Input Text     id=${APP_PACKAGE}:id/ProductNameEditText    ${product name}
    Click Element    id=${APP_PACKAGE}:id/selectPhotoButton
    Wait Until Element Is Visible    id=android:id/button_once    timeout=30s   
    Wait Until Element Is Visible       xpath=//android.widget.TextView[@text='Photos']     timeout=30s         #กรณีรันครั้งเเรก
    Click Element    xpath=//android.widget.TextView[@text='Photos']                #กรณีรันครั้งเเรก
    Click Element    id=android:id/button_once
    Wait Until Element Is Visible    //android.widget.TextView[@text='Pictures']    timeout=30s
    Click Element    com.google.android.apps.photos:id/image
    Wait Until Element Is Visible    xpath=(//android.widget.ImageView)[1]    timeout=30s
    Click Element    xpath=(//android.widget.ImageView)[1]
    Wait Until Element Is Visible    com.google.android.apps.photos:id/done_button    timeout=30s
    Click Element    com.google.android.apps.photos:id/done_button
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/menuhome    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/submitButton
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s
    Close Application


invalid create post 
    [Documentation]    Test invalid create post
    Open Test Application
    Login
    Click Element    id=${APP_PACKAGE}:id/add
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/menuhome    timeout=30s
    Click Element    id=${APP_PACKAGE}:id/submitButton
    Capture Page Screenshot
    Wait Until Element Is Visible    xpath=//*[contains(@text, '')]         timeout=30s
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
