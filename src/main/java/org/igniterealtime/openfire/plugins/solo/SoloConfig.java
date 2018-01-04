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


public class SoloConfig extends HttpServlet {

    private static final Logger Log = LoggerFactory.getLogger(SoloConfig.class);

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
            String serverHost = JiveGlobals.getProperty("xmpp.fqdn", XMPPServer.getInstance().getServerInfo().getHostname());
            String serverPortPlain = JiveGlobals.getProperty("solo.port.plain", JiveGlobals.getProperty("httpbind.port.plain", "7070"));
            String serverPortSecure = JiveGlobals.getProperty("solo.port.secure", JiveGlobals.getProperty("httpbind.port.secure", "7443"));
            boolean secureBlog = JiveGlobals.getBooleanProperty("solo.blog.secure", false);
            boolean blastBlog = JiveGlobals.getBooleanProperty("solo.blog.blast", false);

            boolean update = request.getParameter("update") != null;

            if (update)
            {
                soloName = request.getParameter("soloName");
                JiveGlobals.setProperty("solo.blog.name", soloName);

                serverPortPlain = request.getParameter("serverPortPlain");
                JiveGlobals.setProperty("solo.port.plain", serverPortPlain);

                serverPortSecure = request.getParameter("serverPortSecure");
                JiveGlobals.setProperty("solo.port.secure", serverPortSecure);

                secureBlog = request.getParameter("secureBlog") != null && "on".equals(request.getParameter("secureBlog"));
                JiveGlobals.setProperty("solo.blog.secure", secureBlog ? "true" : "false");

                blastBlog = request.getParameter("blastBlog") != null && "on".equals(request.getParameter("blastBlog"));
                JiveGlobals.setProperty("solo.blog.blast", blastBlog ? "true" : "false");
            }


            String url = "http://" + serverHost + ":" + serverPortPlain + "/" + soloName;

            if (secureBlog)
            {
                url = "https://" + serverHost + ":" + serverPortSecure + "/" + soloName;
            }

            String soloNameLabel    = LocaleUtils.getLocalizedString("config.solo.name.label", "solo");
            String soloNameHelp     = LocaleUtils.getLocalizedString("config.solo.name.help", "solo");
            String httpPortLabel    = LocaleUtils.getLocalizedString("config.solo.http.label", "solo");
            String httpPortHelp     = LocaleUtils.getLocalizedString("config.solo.http.help", "solo");
            String httpsPortLabel   = LocaleUtils.getLocalizedString("config.solo.https.label", "solo");
            String httpsPortHelp     = LocaleUtils.getLocalizedString("config.solo.https.help", "solo");
            String secureBlogLabel  = LocaleUtils.getLocalizedString("config.solo.secure.label", "solo");
            String secureBlogHelp   = LocaleUtils.getLocalizedString("config.solo.secure.help", "solo");
            String blastBlogLabel  = LocaleUtils.getLocalizedString("config.solo.blast.label", "solo");
            String blastBlogHelp   = LocaleUtils.getLocalizedString("config.solo.blast.help", "solo");

            out.println("");
            out.println("<html>");
            out.println("    <head>");
            out.println("        <title>Solo Blogger Settings</title>");
            out.println("        <meta name=\"pageID\" content=\"solo-config\"/>");
            out.println("    </head>");
            out.println("<body>");
            out.println("<form action=\"soloConfig\" method=\"get\">");

            out.println("<div class=\"jive-contentBoxHeader\">General</div>");
            out.println("<div class=\"jive-contentBox\">");
            out.println("<table>");
            out.println("       <tr><td>" + soloNameLabel + "</td><td><input size='10' type='text' name='soloName' id='soloName' value='" + soloName + "'></td>");
            out.println("           <td>" + soloNameHelp + "</tr>");
            out.println("       <tr><td>" + httpPortLabel + "</td><td><input size='10' type='text' name='serverPortPlain' id='serverPortPlain' value='" + serverPortPlain + "'></td>");
            out.println("           <td>" + httpPortHelp + "</td></tr>");
            out.println("       <tr><td>" + httpsPortLabel + "</td><td><input size='10' type='text' name='serverPortSecure' id='serverPortSecure' value='" + serverPortSecure + "'></td>");
            out.println("           <td>" + httpsPortHelp + "</td></tr>");

            if (secureBlog) {
                out.println("       <tr><td>" + secureBlogLabel + "</td><td><input size='10' type='checkbox' name='secureBlog' id='secureBlog' value='yes' checked/></td>");
            } else {
                out.println("       <tr><td>" + secureBlogLabel + "</td><td><input size='10' type='checkbox' name='secureBlog' id='secureBlog'/></td>");
            }
            out.println("           <td>" + secureBlogHelp + " <a href='" + url + "' target='_blank'>" + url + "</a></td></tr>");

            if (blastBlog) {
                out.println("       <tr><td>" + blastBlogLabel + "</td><td><input size='10' type='checkbox' name='blastBlog' id='blastBlog' value='yes' checked/></td>");
            } else {
                out.println("       <tr><td>" + blastBlogLabel + "</td><td><input size='10' type='checkbox' name='blastBlog' id='blastBlog'/></td>");
            }
            out.println("           <td>" + blastBlogHelp + "</td></tr>");

            out.println("       <tr>");
            out.println("           <td><input type='submit' name='update' value='Update'/>");
            out.println("       </tr>");
            out.println("</table>");
            out.println("</div>");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");

        }
        catch (Exception e) {
            Log.error( "SoloConfig", e);
        }
    }
}

