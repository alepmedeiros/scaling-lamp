package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class CustomerController {
    
    @Autowired
    private CustomerService customerService;

    @GetMapping(value="customer/{customerId}")
    public SomeData getCustomer(@PathVariable customerId) {
        return customerService.getCustomerById(customerId);
    }
    
}
