package org.dipayan.practice;

public class Square implements Shape{
	
	public int length;
	public String type;
	

	public Square(int length, String type) {
		super();
		this.length = length;
		this.type = type;
	}

	public int getLength() {
		return length;
	}

	public Square(int length) {
		super();
		this.length = length;
	}


	public void draw()
	{
		System.out.println("A square is drawn and the length is:"+getLength());
		System.out.println("The square is:"+type);
	}
	

}
