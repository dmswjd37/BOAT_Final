package com.boat.mybatis.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Board;
import com.boat.domain.ChatMessage;
import com.boat.domain.Member;

@Mapper
public interface ChatMessageMapper {

	//메세지 전송 저장
	public void messageinsert(String content, String uuid, String id, String formattedDate);

	//메세지 로드
	public List<ChatMessage> getChatHistory(String id, String uuid);

}
