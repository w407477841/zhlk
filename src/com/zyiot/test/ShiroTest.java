package com.zyiot.test;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)      

@ContextConfiguration({"classpath:spring-application.xml","classpath:spring-shiro.xml"})  
public class ShiroTest {

    private static Logger logger = Logger.getLogger(ShiroTest.class);
    @Test
    public  void initext() {
        // Using the IniSecurityManagerFactory, which will use the an INI file
        // as the security file.
        Factory<org.apache.shiro.mgt.SecurityManager> factory = 
            new IniSecurityManagerFactory("auth.ini");

        // Setting up the SecurityManager...
        org.apache.shiro.mgt.SecurityManager securityManager 
            = factory.getInstance();
        SecurityUtils.setSecurityManager(securityManager);

        Subject user = SecurityUtils.getSubject();

        logger.info("User is authenticated:  " + user.isAuthenticated());
    }
}