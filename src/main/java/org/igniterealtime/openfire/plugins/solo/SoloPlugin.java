package org.igniterealtime.openfire.plugins.solo;

import org.apache.tomcat.InstanceManager;
import org.apache.tomcat.SimpleInstanceManager;
import org.eclipse.jetty.apache.jsp.JettyJasperInitializer;
import org.eclipse.jetty.plus.annotation.ContainerInitializer;
import org.eclipse.jetty.webapp.WebAppContext;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.container.Plugin;
import org.jivesoftware.openfire.container.PluginManager;
import org.jivesoftware.openfire.http.HttpBindManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.jivesoftware.util.JiveGlobals;


public class SoloPlugin implements Plugin
{
    private static final Logger Log = LoggerFactory.getLogger( SoloPlugin.class );
    private WebAppContext context;

    @Override
    public void initializePlugin( PluginManager manager, File pluginDirectory )
    {
        try
        {
            // Add the Webchat sources to the same context as the one that's providing the BOSH interface.
            String soloName = JiveGlobals.getProperty("solo.blog.name", "solo");
            context = new WebAppContext( null, pluginDirectory.getPath() + File.separator, "/" + soloName );

            // Ensure the JSP engine is initialized correctly (in order to be able to cope with Tomcat/Jasper precompiled JSPs).
            final List<ContainerInitializer> initializers = new ArrayList<>();
            initializers.add( new ContainerInitializer( new JettyJasperInitializer(), null ) );
            context.setAttribute("org.eclipse.jetty.containerInitializers", initializers);
            context.setAttribute( InstanceManager.class.getName(), new SimpleInstanceManager());

            HttpBindManager.getInstance().addJettyHandler( context );
        }
        catch ( Exception e )
        {
            Log.error( "Unable to initialize Solo Blogger", e );
        }
    }

    @Override
    public void destroyPlugin()
    {
        if ( context != null )
        {
            HttpBindManager.getInstance().removeJettyHandler( context );
            context.destroy();
            context = null;
        }
    }
}
