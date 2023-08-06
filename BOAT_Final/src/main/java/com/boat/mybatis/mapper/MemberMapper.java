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
public interface MemberMapper {
	
	public Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson);

	public void setNaverConnection(Map<String, Object> apiJson);

	public Map<String, Object> userNaverLoginPro(Map<String, Object> apiJson);
	
	//사원번호 생성
	public Member isEmpno(String select);
	
	//회원가입 처리
	public int insert(Member m);

	public Member isId(String empno);
	
	//네이버 회원가입 처리
	public int userNaverRegisterPro(Map<String, Object> paramMap);

	//구글
	public Map<String, Object> GoogleConnectionCheck(Map<String, Object> paramMap);
	
	//구글 로그인
	public Map<String, Object> userGoogleLoginPro(Map<String, Object> paramMap);
	
	//구글 회원가입
	public int userGoogleRegisterPro(Map<String, Object> paramMap);

	//아이디 찾기
	public List<Member> getidlist(HashMap<String, String> map);
	
	//비번 설정하려고 찾기
	public Member getPassword(String name, String empno, String email);
	
	//비번 재설정
	public int pwdupdate(String empno, String password, String encPassword);

	//회원 수정
	public int update(Member m);

	//회원 탈퇴
	public int delete(String empno);
	
	//내 글 갯수
	public int getMyListCount(String empno);

	//내 글 목록
	public List<Board> getMyBoardList(HashMap<String, Object> map);

	//채팅 회원 목록?
	public ArrayList<Member> selectUserList();
	
	//주소록 페이지네이션용 카운트
	public int getAddressLcount();
	
	//주소록 메인페이지용 getlist
	public List<Member> getAddressList(HashMap<String, Integer> map);
	
	//주소록 부서설정ajax용 리스트카운트
	public int getOptionListCount(String dept);
	
	//주소록 부서설정용 getlist
	public List<Member> getOptionAddressList(HashMap<String, Object> map);
	

	//관리자
	public List<Member> getMemberList(HashMap<String, Object> map);
	
	//관리자 업데이
	public int update_admin(Member member);

}
