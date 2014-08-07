package org.dipayan.practice;

import org.springframework.beans.factory.BeanNameAware;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Required;

public class TriangleGeometry implements BeanNameAware,InitializingBean,DisposableBean, Shape {
	
	private Point pointA;
	private Point pointB;
	private Point pointC;

	public Point getPointA() {
		return pointA;
	}

	@Required
	public void setPointA(Point pointA) {
		this.pointA = pointA;
	}

	public Point getPointB() {
		return pointB;
	}

	@Required
	public void setPointB(Point pointB) {
		this.pointB = pointB;
	}

	public Point getPointC() {
		return pointC;
	}

	@Required
	public void setPointC(Point pointC) {
		this.pointC = pointC;
	}
	
	
	public void draw()
	{
		System.out.println("The points are as follows \n"+ getPointA().getX()+","+getPointA().getY()+"\n"+getPointB().getX()+","+getPointB().getY()+"\n"+getPointC().getX()+","+getPointC().getY());
	}

	@Override
	public void setBeanName(String beanName) {
		// TODO Auto-generated method stub
		System.out.println("The Bean name is:"+beanName);
	}

	@Override
	public void destroy() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("Bean disposing/destroying method in Triangle Geometry class");
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("Initialization method for bean initialization in Triangle Geometry class");
	}

}
