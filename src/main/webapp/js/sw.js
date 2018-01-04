/**
 * Service worker file.
 *
 * NOTE: This file MUST be located in the root.
 */

'use strict';

console.log('Started', self);

self.addEventListener('install', function (event) {
    self.skipWaiting();
    console.log('Installed', event);
});

self.addEventListener('activate', function (event) {
    console.log('Activated', event);
});

self.addEventListener('push', function (event) {
    var data = event.data.text();
    
    console.log('Push message', data);
    
    var title = 'Push Message';
    var message = data;
        
    if (isJson(data)) {
        data = JSON.parse(data);
        title = data.title;
        message = data.message;
    }

    console.log('Push data:', title, message);

    var myPromise = self.registration.showNotification(title, {body: message });    
    event.waitUntil(myPromise);    
});

var isJson = function (str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}
