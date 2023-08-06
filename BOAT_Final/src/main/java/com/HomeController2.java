package com;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.boat.domain.Member;


@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
@Controller
public class HomeController2 {

	
	
	
	@GetMapping("/index")
	public String hello(HttpSession session) {
		System.out.println("session="+session);
		
		return "/Main/index";
		
	}
	
	
	
}
