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
    data = JSON.parse(data);

    var options = {
        body: data.message,
        icon: 'favicon.png',
        vibrate: [100, 50, 100],
        data: data,
        actions: [
          {action: 'read', title: 'Open Blog',
            icon: 'success-16x16.gif'},
          {action: 'ignore', title: 'Ignore Blog',
            icon: 'delete-16x16.gif'},
        ]
    };
    event.waitUntil(
        self.registration.showNotification(data.title, options)
    );
});

self.addEventListener('notificationclick', function(event) {
    event.notification.close();

    if (event.action === 'read') {
        event.waitUntil(clients.openWindow(event.notification.data.url));
    }
}, false);
