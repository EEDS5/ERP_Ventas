package com.proyecto.erpventas.controller;

import com.proyecto.erpventas.service.TestService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    private final TestService testService;

    public TestController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping("/")
    public String hello() {
        return testService.getWelcomeMessage();
    }
}
