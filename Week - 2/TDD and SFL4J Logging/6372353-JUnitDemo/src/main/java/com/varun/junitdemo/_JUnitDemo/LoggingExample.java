package com.varun.junitdemo._JUnitDemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {

    // Create a logger for this class
    private static final Logger logger = LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {
        logger.error("🚨 This is an error message");
        logger.warn("⚠️ This is a warning message");
    }
}

