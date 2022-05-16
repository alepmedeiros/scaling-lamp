package com.example.demoapi.service;

import com.example.democore.model.PlaneDto;

import org.springframework.stereotype.Service;

@Service
public class PlaneService {
    
public PlaneDto getPlane(){
    return new PlaneDto("Alessandro", 4);
}

}
