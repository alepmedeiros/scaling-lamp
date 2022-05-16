package com.example.democore.model;

public class PlaneDto {
    
    String name;
    int enginesCount;

    public PlaneDto(String name, int enginesCount) {
        this.name = name;
        this.enginesCount = enginesCount;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getEnginesCount() {
        return this.enginesCount;
    }

    public void setEnginesCount(int enginesCount) {
        this.enginesCount = enginesCount;
    }

}
