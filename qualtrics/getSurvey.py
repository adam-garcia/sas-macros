#!/usr/bin/python
import os
import sys
import json
import getopt
import zipfile
import tempfile
import requests


def getSurvey(optsFile):
    with open(optsFile) as data:
        optdata = json.load(data)
    apiToken = str(optdata['apiToken'])
    surveyID = str(optdata['surveyID'])
    useLabels = str(optdata['useLabels'])
    fileFormat = str(optdata['format'])
    tempDir = str(optdata['work'])
    tempDir = os.path.dirname(os.path.realpath('__file__'))
    #Setting static parameters
    rCP = 0
    baseUrl = 'https://ca1.qualtrics.com/API/v3/responseexports/'
    headers = {
        'content-type': "application/json",
        'x-api-token': apiToken,
    }
    #Creating Data Export
    dlRU = baseUrl
    dlRP = ('{"format":"' 
            + fileFormat 
            + '","surveyId":"' 
            + surveyID 
            + '","useLabels":'
            + useLabels
            + '}')
    dlRR = requests.request("POST", 
                            dlRU,
                            data=dlRP, 
                            headers=headers) 
    progressId = dlRR.json()['result']['id']
    #Checking on Data Export Progress and waiting until export is ready
    while rCP < 100:
        rCU = baseUrl + progressId
        rCR = requests.request("GET", rCU, headers=headers)
        rCP = rCR.json()['result']['percentComplete']
        print "Download is " + str(rCP) + " complete"
    #Downloading and unzipping file
    rDlUrl = baseUrl + progressId + '/file'
    rDl = requests.request("GET", rDlUrl, headers=headers, stream=True)
    zipRequest = tempDir.rstrip() + "/request.zip"
    with open(zipRequest, "w") as f:
        for chunk in rDl.iter_content(chunk_size=1024):
            f.write(chunk)
    zipfile.ZipFile(zipRequest).extractall(tempDir.rstrip())


def main(argv):
    options = ''
    try:
        opts, args = getopt.getopt(argv, "i:")
    except getopt.GetoptError:
        sys.exit(2)
    for o, a in opts:
        if o == "-i":
            options = a
        else:
            assert False, "unhandled option"
    print options
    getSurvey(options)

if __name__ == '__main__':
    main(sys.argv[1:])