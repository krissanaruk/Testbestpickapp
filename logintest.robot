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
${INVALID_EMAIL_REGIS}              test1234@gmail.com
${INVALID_PASSWORD_REGIS}           test
${INVALID_EMAIL}              test
${INVALID_PASSWORD}           test
${Null_EMAIL}              
${Null_PASSWORD}
${LOCKED_EMAIL}              ksnr2412@gmail.com
${LOCKED_MESSAGE}            Response: Too many failed login attempts. Try again in 5 minutes.
${LOGIN_ATTEMPTS}            5
${GOOGLE_EMAIL}               terter2412@gmail.com
${GOOGLE_PASSWORD}            terkrub2412

 
*** Test Cases ***
Valid Login Test
    [Documentation]    Test valid login flow
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s
    Close Application
 
Invalid Login Test1
    [Documentation]    Test invalid login email not register
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${INVALID_EMAIL_REGIS}
    Input Text         id=${APP_PACKAGE}:id/password    ${INVALID_PASSWORD_REGIS}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Page Contains    Response: No user found    timeout=30s
    Close Application

 Invalid Login Test
    [Documentation]    Test invalid login with incorrect credentials
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${INVALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${INVALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Page Contains    Response: No user found    timeout=30s
    Close Application
 
Invalid Login Test
    [Documentation]    Test Null login
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${Null_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${Null_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s
    Close Application


Account Lock After 5 Failed Attempts
    [Documentation]    Test that the account is locked after 5 failed login attempts
    Open Test Application
     FOR    ${i}    IN RANGE    1    ${${LOGIN_ATTEMPTS} + 1}
        Input Text         id=${APP_PACKAGE}:id/Email       ${LOCKED_EMAIL}
        Input Text         id=${APP_PACKAGE}:id/password    ${INVALID_PASSWORD}
        Click Element      id=${APP_PACKAGE}:id/loginButton
        ${isLocked}=    Run Keyword And Return Status    Wait Until Page Contains    ${LOCKED_MESSAGE}    timeout=5s
        Run Keyword If    ${isLocked}    Exit For Loop
    END
    Close Application
   
   
Google SignIn functionality 
    [Documentation]    Test the Google Sign-In flow
    Open Test Application
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logingoogle    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/logingoogle
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@resource-id='identifierId']    timeout=30s
    Input Text    xpath=//android.widget.EditText[@resource-id='identifierId']    ${GOOGLE_EMAIL}
    Wait Until Element Is Visible    xpath=(//android.widget.Button)[4]    timeout=30s
    Click Element    xpath=(//android.widget.Button)[4]
    Sleep    3s  
    Wait Until Element Is Visible    xpath=(//android.widget.EditText[@password='true'])[1]    timeout=30s
    Input Text    xpath=(//android.widget.EditText[@password='true'])[1]    ${GOOGLE_PASSWORD}
    Wait Until Element Is Visible    xpath=(//android.widget.Button)[2]    timeout=30s
    Click Element    xpath=(//android.widget.Button)[2]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text='I agree']    timeout=30s
    Click Element    xpath=//android.widget.Button[@text='I agree']
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text='ACCEPT']    timeout=30s
    Click Element    xpath=//android.widget.Button[@text='ACCEPT']
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logingoogle    timeout=30s
    Close Application

Forget Password function
    [Documentation]    Test that clicking on Forget Password navigates to the Forget Password page
    Open Test Application
    Click Element      id=${APP_PACKAGE}:id/forgetpass
    Wait Until Element Is Visible   xpath=//android.widget.TextView[@text='ForgetPassword']    timeout=30s  
    Close Application

register function
    [Documentation]    Test that clicking on Forget Password navigates to the Forget Password page
    Open Test Application
    Click Element      id=${APP_PACKAGE}:id/register
    Wait Until Element Is Visible   xpath=//android.widget.TextView[@text='Create New Account']    timeout=30s  
    Close Application

*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s

