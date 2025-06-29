package com.varun.junitdemo._JUnitDemo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {

    @Test
    public void testAdd() {
        Calculator calc = new Calculator();
        int result = calc.add(5, 7);
        System.out.println("Addition result: " + result); 
        assertEquals(12, result);
    }
}
