package org.igniterealtime.openfire.plugins.solo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.*;
import org.slf4j.Logger;

import org.jivesoftware.util.*;
import org.jivesoftware.openfire.XMPPServer;


public class ServiceWorker extends HttpServlet {

    private static final Logger Log = LoggerFactory.getLogger(ServiceWorker.class);

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Content-Type", "application/javascript");
        response.setHeader("Connection", "close");

        ServletOutputStream out = response.getOutputStream();

        try {
            out.println("'use strict';");
            out.println("console.log('Started', self);");

            out.println("self.addEventListener('install', function (event) {");
            out.println("    self.skipWaiting();");
            out.println("    console.log('Installed', event);");
            out.println("});");

            out.println("self.addEventListener('activate', function (event) {");
                out.println("console.log('Activated', event);");
            out.println("});");

            out.println("self.addEventListener('push', function (event) {");
            out.println("    var data = event.data.text();");

            out.println("   console.log('Push message', data);");
            out.println("    data = JSON.parse(data);");

            out.println("    var options = {");
            out.println("       body: data.message,");
            out.println("        icon: 'favicon.png',");
            out.println("vibrate: [100, 50, 100],");
            out.println("        data: data,");
            out.println("actions: [");
            out.println("          {action: 'read', title: 'Open Blog',");
            out.println("            icon: 'success-16x16.gif'},");
            out.println("         {action: 'ignore', title: 'Ignore Blog',");
            out.println("            icon: 'delete-16x16.gif'},");
            out.println("        ]");
            out.println("   };");
            out.println("    event.waitUntil(");
            out.println("        self.registration.showNotification(data.title, options)");
            out.println("    );");
            out.println("});");

            out.println("self.addEventListener('notificationclick', function(event) {");
            out.println("    event.notification.close();");

            out.println("    if (event.action === 'read') {");
            out.println("        event.waitUntil(clients.openWindow(event.notification.data.url));");
            out.println("    }");
            out.println("}, false);");
        }
        catch (Exception e) {
            Log.error( "ServiceWorker", e);
        }
    }
}

