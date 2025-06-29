package com.varun.junitdemo._JUnitDemo;

import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorLifecycleTest {

    Calculator calc;

    @BeforeEach
    public void setup() {
        System.out.println("Setting up calculator...");
        calc = new Calculator(); // Arrange
    }

    @AfterEach
    public void teardown() {
        System.out.println("Cleaning up after test...");
        calc = null;
    }

    @Test
    public void testAdd() {
        // Act
        int result = calc.add(10, 5);

        // Assert
        assertEquals(15, result);
    }

    @Test
    public void testAddNegative() {
        int result = calc.add(-2, -3);
        assertEquals(-5, result);
    }
}
