package org.dipayan.practice;

import org.springframework.beans.factory.annotation.Required;

public class Triangle implements Shape {
	
	public String type;
	

	public String getType() {
		return type;
	}

	
	@Required
	public void setType(String type) {
		this.type = type;
	}


	public void draw()
	{
		System.out.println("A triangle is being drawn which is of type: "+getType());
	}
}
