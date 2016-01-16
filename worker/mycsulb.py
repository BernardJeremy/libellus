#!/usr/bin/env python3

from selenium import webdriver
import time

driver = webdriver.Chrome()

def do_search():
    print('doing search right now')
    try:
        select = driver.find_element_by_id('SSR_CLSRCH_WRK_SUBJECT_SRCH$0')
    except:
        print('trying again to find the subject option')
        return do_search()

    terms = driver.find_element_by_id('CLASS_SRCH_WRK2_STRM$45$').find_elements_by_tag_name('option')
    for e in terms:
        if e.get_attribute('value') == '2162':
            e.click()

    elements = select.find_elements_by_tag_name('option')
    for e in elements:
        if e.get_attribute('value') == 'CECS':
            time.sleep(1)
            try:
                e.click()
            except:
                do_search()

            driver.save_screenshot('fifa2.png')
            search_button = driver.find_element_by_id('CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH')
            search_button.click()

            time.sleep(1)
            if driver.page_source.find('Your search will return over 50 classes, would you like to continue') != -1:
                try:
                    ok = driver.find_element_by_id('#ICSave')
                    ok.click()
                except:
                    return workflow()


            exit(0)
            do_search()
            break
    exit(0)

def tryclickonlink(name, i):

    max_try = 5

    for tr in range(1, max_try):
        try:
            link = None
            if i:
                link = driver.find_element_by_id(name)
            else:
                link = driver.find_element_by_link_text(name)
            link.click()
        except:
            print('exception thrown, trying again to click on {} (#{})'.format(name, tr))
            driver.save_screenshot('error.png')
            try:
                driver.find_element_by_class_name('ps-button')
                print('on login page, trying again')
                workflow()
            except:
                pass
            try:
                driver.find_element_by_link_text('Search')
                return 
            except:
                pass
            continue
        return

def workflow():

    driver.get('https://my.cms.csulb.edu/psp/paprd/EMPLOYEE/EMPL/h/?tab=PAPP_GUEST')
    time.sleep(1)
    try:
        userid = driver.find_element_by_id('userid')
    except:
        return workflow()

    userid.send_keys("014930823")
    passwd = driver.find_element_by_id('pwd')
    passwd.send_keys("CSULBcpasmal00")
    
    commit = driver.find_element_by_name('Submit')
    commit.click()

    tryclickonlink('Student Center', False)
    driver.save_screenshot('lol.png')

    driver.get('https://cmsweb.cms.csulb.edu/psc/HLBPRD/EMPLOYEE/SA/c/SA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL?ICType=Panel&Menu=SA_LEARNER_SERVICES&Market=GBL&PanelGroupName=SSS_STUDENT_CENTER&FolderPath=PORTAL_ROOT_OBJECT.LB_STUDENT_CENTER&IsFolder=false&IgnoreParamTempl=FolderPath%2cIsFolder&PortalActualURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentProvider=SA&PortalCRefLabel=Student%20Center&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsp%2fpaprd%2f&PortalURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsc%2fpaprd%2f&PortalHostNode=EMPL&NoCrumbs=yes&PortalKeyStruct=yes')

    tryclickonlink('Search For Classes', False)
    driver.find_element_by_link_text('Search')
    do_search()
    driver.save_screenshot('sc.png')

workflow()
