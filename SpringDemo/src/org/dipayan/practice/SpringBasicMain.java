package org.dipayan.practice;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.FileSystemResource;

public class SpringBasicMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		//Triangle tri = new Triangle();
		//BeanFactory fac = new XmlBeanFactory(new FileSystemResource("Spring.xml"));
		AbstractApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
		Shape tri =(Shape) context.getBean("triangle");
		Shape sq = (Shape) context.getBean("square");
		Shape tg = (Shape) context.getBean("TriangleGeometry");
		Shape sg = (Shape) context.getBean("SquareGeometry");
		context.registerShutdownHook();
		tri.draw();
		sq.draw();
		tg.draw();
		sg.draw();
	}

}
