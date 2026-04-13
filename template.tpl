___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Qonfi",
  "categories": ["PERSONALIZATION", "SALES"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "New North Digital",
    "thumbnail": ""
  },
  "description": "Qonfi guided selling widget. Load the Qonfi script to enable product recommendation wizards and track interactions via the dataLayer.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "customDataLayerName",
    "displayName": "Custom dataLayer name (optional)",
    "simpleValueType": true,
    "help": "Leave empty to use the default \u0027dataLayer\u0027. Only set this if you use a custom dataLayer variable name for Qonfi events.",
    "canBeEmptyString": true
  },
  {
    "type": "GROUP",
    "name": "debugging",
    "displayName": "Debugging",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "debug",
        "checkboxText": "Log debug messages to console",
        "simpleValueType": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var log = require('logToConsole');
var injectScript = require('injectScript');
var setInWindow = require('setInWindow');
var makeString = require('makeString');

var enableDebug = data.debug;
var debugLog = function(msg) {
  if (enableDebug) log('Qonfi GTM - ' + msg);
};

// Optionally set custom dataLayer name before script loads
if (data.customDataLayerName) {
  var dlName = makeString(data.customDataLayerName);
  setInWindow('qonfiDataLayer', dlName, true);
  debugLog('Set custom dataLayer name: ' + dlName);
}

// Inject the Qonfi wizard script
var scriptUrl = 'https://platform.getqonfi.com/build-wizard3/wizard3.js';

debugLog('Loading Qonfi script');

injectScript(scriptUrl, function() {
  debugLog('Qonfi script loaded');
  data.gtmOnSuccess();
}, function() {
  debugLog('Qonfi script failed to load');
  data.gtmOnFailure();
}, 'qonfi-wizard');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "vpiVersion": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://platform.getqonfi.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "is498": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "vpiVersion": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "qonfiDataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "vpiVersion": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: "Script loads successfully"
  code: |-
    var mockData = {};

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
- name: "Custom dataLayer name is set before script loads"
  code: |-
    var mockData = {
      customDataLayerName: 'myCustomDL'
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    runCode(mockData);

    assertApi('setInWindow').wasCalledWith('qonfiDataLayer', 'myCustomDL', true);
    assertApi('gtmOnSuccess').wasCalled();
- name: "Script failure calls gtmOnFailure"
  code: |-
    var mockData = {};

    mock('injectScript', function(url, success, failure, token) {
      failure();
    });

    runCode(mockData);

    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Created on 4/3/2026, by New North Digital.
