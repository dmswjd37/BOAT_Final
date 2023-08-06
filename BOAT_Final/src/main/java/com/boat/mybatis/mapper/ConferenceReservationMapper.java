package com.boat.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.ConferenceReservation;

@Mapper
public interface ConferenceReservationMapper {

	 public List<ConferenceReservation> getcal(String tab);
	 
	 public void insert1(ConferenceReservation conferenceReservation);

	public List<ConferenceReservation> admit(int startrow, int endrow, String tab);

	public int listcount(String tab);

	public void admit_pro(ConferenceReservation c2);

	public void reject_pro(ConferenceReservation c2);

	public int check_pro(ConferenceReservation c2);

	
}
