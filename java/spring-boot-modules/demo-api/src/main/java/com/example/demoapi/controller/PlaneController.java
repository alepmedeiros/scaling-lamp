package com.example.demoapi.controller;

import com.example.demoapi.service.PlaneService;
import com.example.democore.model.PlaneDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/v1")
public class PlaneController {
    
    @Autowired
    PlaneService planeService;

    @GetMapping(value="/planes")
    public ResponseEntity<PlaneDto> getPlane() {
        PlaneDto planeDto = planeService.getPlane();
        return new ResponseEntity<>(planeDto, HttpStatus.OK);
    }
    
}
