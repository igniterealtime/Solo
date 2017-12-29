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


public class SoloAdmin extends HttpServlet {

    private static final Logger Log = LoggerFactory.getLogger(SoloAdmin.class);

    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Content-Type", "text/html");
        response.setHeader("Connection", "close");

        ServletOutputStream out = response.getOutputStream();

        try {
            String soloName = JiveGlobals.getProperty("solo.blog.name", "solo");

            String serverScheme = "http";
            String serverHost = JiveGlobals.getProperty("xmpp.fqdn", XMPPServer.getInstance().getServerInfo().getHostname());
            String serverPort = JiveGlobals.getProperty("solo.port.plain", JiveGlobals.getProperty("httpbind.port.plain", "7070"));

            boolean secureBlog = JiveGlobals.getBooleanProperty("solo.blog.secure", false);

            if (secureBlog)
            {
                serverScheme = "https";
                serverPort = JiveGlobals.getProperty("solo.port.secure", JiveGlobals.getProperty("httpbind.port.secure", "7443"));
            }

            out.println("");
            out.println("<html>");
            out.println("    <head>");
            out.println("        <title>Solo Blogger Admin</title>");
            out.println("        <meta name=\"pageID\" content=\"solo-admin\"/>");
            out.println("        <style type=\"text/css\">");
            out.println("            #jive-main table, #jive-main-content {");
            out.println("                height: 92%;");
            out.println("            }");
            out.println("        </style>");
            out.println("    </head>");
            out.println("<body>");
            out.println("<iframe frameborder='0' style='border:0px; border-width:0px; margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; width:100%;height:100%;' src='" + serverScheme + "://" + serverHost + ":" + serverPort + "/" + soloName + "/admin-index.do#main'></iframe>");
            out.println("</body>");
            out.println("</html>");

        }
        catch (Exception e) {
            Log.error( "SoloAdmin", e);
        }
    }
}

