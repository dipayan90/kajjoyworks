package org.dipayan.practice;

import java.util.List;

public class SquareGeometry implements Shape {
	
	public List<Point> points;
	
	
	public List<Point> getPoints() {
		return points;
	}


	public void setPoints(List<Point> points) {
		this.points = points;
	}


	public void draw()
	{
		int i=1;
		for(Point point:points)
		{
			System.out.println("point"+i+": ("+point.getX()+","+point.getY()+")");
		}
	}
	
	public void initMethod()
	{
		System.out.println("This is init method inside square Geometry class");
	}
	
	public void erase()
	{
		System.out.println("This is destroy method inside square Geometry class");
	}

}
