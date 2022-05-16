package com.example.domain.service;

import com.example.domain.aggregate.Customer;

public interface CustomerService {
    public Customer getCustomerById(Integer customerId);
}
