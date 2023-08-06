package com.boat.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.boat.domain.Board;
import com.boat.domain.ChatMessage;
import com.boat.domain.Member;

public interface MemberService {

	//네이버 가입했는지 확인
	public Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson);

	//이메일 있으면 해당 이메일로 네이버 가입
	public void setNaverConnection(Map<String, Object> apiJson);

	//네이버 로그인
	public Map<String, Object> userNaverLoginPro(Map<String, Object> apiJson);

	//사원번호 생성
	public int isEmpno(String select);

	//회원가입 처리
	public int insert(Member member);

	//정보
	public Member member_info(String id);

	//네이버 회원가입 처리
	public int userNaverRegisterPro(Map<String, Object> paramMap);

	//구글 유저 확인
	public Map<String, Object> GoogleConnectionCheck(Map<String, Object> paramMap);

	//구글 로그인
	public Map<String, Object> userGoogleLoginPro(Map<String, Object> paramMap);

	//구글 회원가입
	public int userGoogleRegisterPro(Map<String, Object> paramMap);

	//아이디 찾기
	public List<Member> getidlist(String name, String email);

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
	public List<Board> getMyBoardList(int page, int limit, String empno);

	//채팅 회원 목록?
	public ArrayList<Member> selectUserList();
	
	//주소록 페이지네이션용 카운트
	public int getAddressLcount();
	
	//주소록 메인페이지용 getlist
	public List<Member> getAddressList(int page, int limit);
	
	//주소록 부서설정ajax용 리스트카운트
	public int getOptionListCount(String dept);
	
	//주소록 부서설정용 getlist
	public List<Member> getOptionAddressList(int page, int limit, String dept);
	
	//관리자페이지 정보불러오기
	public List<Member> getMemberList(String empno);
	
	//관리자페이지 업데이트
	public int update_admin(Member member);


}
