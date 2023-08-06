package com.boat.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.ConferenceReservation;
import com.boat.mybatis.mapper.ConferenceReservationMapper;

@Service
public class ConferenceReservationServiceImpl implements ConferenceReservationService{

	
	  private ConferenceReservationMapper c3;
	  
	  @Autowired
	  public ConferenceReservationServiceImpl(ConferenceReservationMapper conferenceReservationMapper) {
		  this.c3 = conferenceReservationMapper;
	  }
	
	@Override
	 public List<ConferenceReservation> getcal(String tab) {
		    return c3.getcal(tab);
		  }

	@Override
	public void insert1(ConferenceReservation conferenceReservation) {
		c3.insert1(conferenceReservation);
		
	}

	@Override
	public List<ConferenceReservation> admit(int startrow, int endrow, String tab) {
		return c3.admit(startrow,endrow,tab);
	}



	@Override
	public int listcount(String tab) {
		return c3.listcount(tab);
	}

	

	@Override
	public void admit_pro(ConferenceReservation c2) {
		c3.admit_pro(c2);
		
	}
	
	@Override
	public void reject_pro(ConferenceReservation c2) {
		c3.reject_pro(c2);
		
	}

	@Override
	public int check_pro(ConferenceReservation c2) {
		return c3.check_pro(c2);
	}






	
	
	
}
