package com.boat.controller.map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MapContoller {

	private static final Logger logger = LoggerFactory.getLogger(MapContoller.class);

	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String mapPage() {

		return "Calendar/map";
	}

	@RequestMapping(value = "/cal", method = RequestMethod.GET)
	public String fullcalPage() {

		return "Calendar/fullcalendar";
	}
}// 클래스 end
