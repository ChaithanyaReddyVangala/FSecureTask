*** Settings ***

Documentation     A resource file with reusable keywords and variables.
Resource     Settings.robot

Test Setup   Setup Browser   ${platform}   ${env}




*** Test Cases ***


Verify Youtube page and return thumbnail and video urls

    [Documentation]   Verify Youtube page and return thumbnail and video urls
    [tags]   

    launch youtube home page   ${URL} 
    verify if youtube page is loaded 
    input search text   Selenium
    click search button
    Retrieve all thumbnail image urls 
    Retrieve all video link urls


        
