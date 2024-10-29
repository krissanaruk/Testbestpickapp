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
${INVALID_EMAIL_REGIS}              test1234@gmail.com
${INVALID_PASSWORD_REGIS}           test
${INVALID_EMAIL}              test
${INVALID_PASSWORD}           test
${Null_EMAIL}              
${Null_PASSWORD}
${LOCKED_EMAIL}              ksnr2412@gmail.com
${LOCKED_MESSAGE}            Response: Too many failed login attempts. Try again in 5 minutes.
${LOGIN_ATTEMPTS}            5
${GOOGLE_EMAIL}               Vachiravitcp1@gmail.com
${GOOGLE_PASSWORD}            0809084781

 
*** Test Cases ***
Valid Login Test
    [Documentation]    ตรวจสอบการเข้าสู่ระบบด้วยอีเมลและรหัสที่ถูกต้อง
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s
    Close Application
 
Invalid Login Test1
    [Documentation]    ตรวจสอบการเข้าสู่ระบบด้วยอีเมลที่ไม่ได้ลงทะเบียน
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${INVALID_EMAIL_REGIS}
    Input Text         id=${APP_PACKAGE}:id/password    ${INVALID_PASSWORD_REGIS}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Page Contains    Email or Password is incorrect.    timeout=30s
    Close Application

 Invalid Login Test2
    [Documentation]    ตรวจสอบการเข้าสู่ระบบด้วยข้อมูลที่ไม่ใช่อีเมล
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${INVALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${INVALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Page Contains    Email or Password is incorrect.    timeout=30s
    Close Application
 
Invalid Login Test
    [Documentation]    ตรวจสอบการเข้าสู่ระบบด้วยการไม่กรอกข้อมูล
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${Null_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${Null_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s
    Close Application


Account Lock After 5 Failed Attempts
    [Documentation]   ตรวจสอบการล็อคบัญชีชั่วคราว
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
    [Documentation]    ตรวจสอบการเข้าสู่ระบบด้วย Google
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
    [Documentation]    ตรวจสอบปุ่ม Forget password
    Open Test Application
    Click Element      id=${APP_PACKAGE}:id/forgetpass
    Wait Until Element Is Visible   xpath=//android.widget.TextView[@text='ForgetPassword']    timeout=30s  
    Close Application

register function
    [Documentation]    ตรวจสอบปุ่ม Register
    Open Test Application
    Click Element      id=${APP_PACKAGE}:id/register
    Wait Until Element Is Visible   xpath=//android.widget.TextView[@text='Create New Account']    timeout=30s  
    Close Application

register function
    [Documentation]    ตรวจสอบปุ่ม Register
    Open Test Application
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}

Test Show Hide Password Functionality
    [Documentation]    ตรวจสอบฟังก์ชันแสดง/ซ่อนรหัสผ่านในหน้าล็อกอิน
    Open Test Application
    Input Text    id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/togglePasswordConfirm
    Wait Until Page Contains    ${VALID_PASSWORD}    timeout=5s
    Click Element    id=${APP_PACKAGE}:id/togglePasswordConfirm
    Wait Until Page Does Not Contain    ${VALID_PASSWORD}    timeout=5s
    Close Application

*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s

