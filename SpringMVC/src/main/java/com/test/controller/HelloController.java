package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/hello")
public class HelloController {
	
	@RequestMapping(value="/view1",method = RequestMethod.GET)
	   public String printHello(@RequestParam("id") int id,ModelMap model) {
	      model.addAttribute("message", "Hello Spring MVC Framework!");
	      model.addAttribute("id",id);
	      return "hello";
	   }
	
	@RequestMapping(value="/view/{id}",method=RequestMethod.GET)
		public String test(@PathVariable("id") int id,ModelMap model){
		model.addAttribute("id",id);
		return "hello";
	}
}
