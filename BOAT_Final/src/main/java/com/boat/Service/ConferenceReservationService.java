package com.boat.Service;

import java.util.List;

import com.boat.domain.ConferenceReservation;

public interface ConferenceReservationService {

	public List<ConferenceReservation> getcal(String tab);

	public void insert1(ConferenceReservation conferenceReservation);

	public List<ConferenceReservation> admit(int startrow, int endrow, String tab);

	public int listcount(String tab);

	public void admit_pro(ConferenceReservation c2);

	public void reject_pro(ConferenceReservation c2);

	public int check_pro(ConferenceReservation c2);
	
	
}
