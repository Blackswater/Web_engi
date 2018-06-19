package com.chimerasys;


public class Tag {
    
    private final int id;
    private String category;
    private String label;
    private String css;
    
    public Tag(int id) {
	this.id = id;
    }
    
    public int getId() {
	    return id;
	}
    
    public String getCategory() {
	    return this.category;
	}
    
    public void setCategory(String firstname) {
	    this.category = firstname;
	}
    
    public String getLabel() {
	    return this.label;
	}
    
    public void setLabel(String lastname) {
	    this.label = lastname;
	}
    
    public String getCss() {
	return this.css;
    }
	
    public void setCss(String lastname) {
	    this.css = lastname;
	}
	
}
