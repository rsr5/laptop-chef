#!/usr/bin/python

import requests
import json

from bs4 import BeautifulSoup

# SITE_URL = 'http://www.basingstoke.gov.uk/rte.aspx?id=1270'
SITE_URL = 'https://www.basingstoke.gov.uk/bincollections'


def find_view_state(html_doc):
    """
    Given some HTML the viewstate fields are returned as a dictionary.
    """
    soup = BeautifulSoup(html_doc)

    vids = ['__VIEWSTATE', '__EVENTVALIDATION', '__VIEWSTATEGENERATOR',
            '__EVENTARGUMENT', '__EVENTTARGET']

    return dict([(vid, soup.find('input', id=vid).get('value'))
                 for vid in vids
                 if soup.find('input', id=vid)])


def retrieve_postcode_page():
    """
    Performs an HTTP GET request to get the page that the paostcode is entered
    on.  It is needed in order to get the VIEWSTATE variables.
    """
    response = requests.get(SITE_URL)
    return response.text


def send_postcode(view_state, postcode):
    """
    Performs an HTTP POST request and sends the postcode, plus the VIEWSTATE.
    The response should be another form, more VIEWSTATE and a choice of
    house address.
    """
    form = {
        "__EVENTARGUMENT": "",
        "__EVENTTARGET": "rteelem$ctl05$gapAddress$ctl03",
        "__EVENTVALIDATION": view_state['__EVENTVALIDATION'],
        "__VIEWSTATE": view_state['__VIEWSTATE'],
        "__VIEWSTATEGENERATOR": view_state['__VIEWSTATEGENERATOR'],
        "rteelem$ctl05$gapAddress$ctl02": postcode,
        "rteelem$ctl05$hidLastVerticalPosition": 0
    }
    response = requests.post(SITE_URL, data=form)
    return response.text


def find_street_addresses(address_page):
    """
    Returns all the street address options and their corresponding identifyier.
    """
    soup = BeautifulSoup(address_page)

    select = soup.find('select')

    return dict([(inputelement.get_text(), inputelement.get('value'))
                 for inputelement in select.children
                 if inputelement != u'\n'])


def send_streetaddress(view_state, street_id):
    """
    Performs an HTTP POST request and send the street address, plus the
    VIEWSTATE.  The response should contain the next bin days for the above
    street_id.  The bin day information will be returned.
    """
    form = {
        "__EVENTARGUMENT": "",
        "__EVENTTARGET": "rteelem$ctl05$gapAddress$ctl07",
        "__EVENTVALIDATION": view_state['__EVENTVALIDATION'],
        "__VIEWSTATE": view_state['__VIEWSTATE'],
        "__VIEWSTATEGENERATOR": view_state['__VIEWSTATEGENERATOR'],
        "rteelem$ctl05$gapAddress$ctl06": street_id,
        "rteelem$ctl05$hidLastVerticalPosition": 0
    }
    response = requests.post(SITE_URL, data=form)
    return response.text


def get_street_id(addresses, street_address):
    """
    Gets the corresponding ``street_id`` for ``street_address``.
    """
    return [street_id
            for address, street_id in addresses.iteritems()
            if address.startswith(street_address)].pop()


def find_address(bin_page):
    """
    Returns the full address for the waste query performed.
    """
    soup = BeautifulSoup(bin_page)
    address_span = soup.find('span', id='rteelem_ctl05_gapAddress')
    return address_span.find('textarea').get_text().lstrip()


def find_waste_information(bin_page):
    """
    Finds the information regarding land fill waste collections.
    """
    soup = BeautifulSoup(bin_page)

    waste_table = soup.find('h2', text='Waste collection dates').next_sibling

    return {
        'schedule': waste_table.find_all('strong')[0].get_text(),
        'day_of_the_week': waste_table.find_all('strong')[1].get_text(),
        'next_collections': [li.span.get_text()
                             for li in waste_table.find_all('li')]
    }


def find_recycling_information(bin_page):
    """
    Finds the information regarding recycling collections.
    """
    soup = BeautifulSoup(bin_page)

    waste_table = soup.find('h2',
                            text='Recycling collection dates').next_sibling

    return {
        'schedule': waste_table.find_all('strong')[1].get_text(),
        'week_colour': waste_table.find_all('strong')[0].get_text(),
        'day_of_the_week': waste_table.find_all('strong')[2].get_text(),
        'next_collections': [li.span.get_text()
                             for li in waste_table.find_all('li')]
    }


def find_green_information(bin_page):
    """
    Finds the information regarding green collections.
    """
    soup = BeautifulSoup(bin_page)

    waste_table = soup.find('h2',
                            text='Garden waste collection dates').next_sibling

    return {
        'schedule': waste_table.find_all('strong')[1].get_text(),
        'week_id': waste_table.find_all('strong')[0].get_text(),
        'day_of_the_week': waste_table.find_all('strong')[2].get_text(),
        'next_collections': [li.span.get_text()
                             for li in waste_table.find_all('li')]
    }


def get_bin_day(postcode, street_address):
    """
    Returns the next bin for ``postcode`` and ``street_address``.
    """
    view_state = find_view_state(retrieve_postcode_page())
    address_page = send_postcode(view_state, postcode)
    view_state = find_view_state(address_page)
    addresses = find_street_addresses(address_page)
    street_id = get_street_id(addresses, street_address)
    bin_page = send_streetaddress(view_state, street_id)

    bin_info = {
        'address': find_address(bin_page),
        'waste_info': find_waste_information(bin_page),
        'recycling': find_recycling_information(bin_page),
        'green_waste': find_green_information(bin_page)
    }

    return bin_info

if __name__ == '__main__':

    print json.dumps(get_bin_day("postcode", "street address"))
